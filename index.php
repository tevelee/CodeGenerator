<?php

require_once 'vendor/autoload.php';

$loader = new Twig_Loader_Filesystem('templates');
$twig = new Twig_Environment($loader, array("autoescape" => false));

$lowerCapitalizeFilter = new Twig_SimpleFilter('lowerCapitalize', function ($string) {
    return strtolower(substr($string, 0, 1)).substr($string, 1);
});
$twig->addFilter($lowerCapitalizeFilter);

$upperCapitalizeFilter= new Twig_SimpleFilter('upperCapitalize', function ($string) {
    return strtoupper(substr($string, 0, 1)).substr($string, 1);
});
$twig->addFilter($upperCapitalizeFilter);

class Twig_Node_File extends Twig_Node
{
    public function __construct($name, $expression, $body, $line, $tag = null)
    {
    	parent::__construct(array('name' => $name, 'expression' => $expression, 'body' => $body), array(), $line, $tag);
    }

    public function compile(Twig_Compiler $compiler)
    {
        if (strlen($body) > 0) {
            $compiler
                ->addDebugInfo($this)
                ->write('ob_start();')
                ->subcompile($this->getNode('body'))
                ->write('$content = ob_get_contents();')
                ->write('ob_end_clean();')
                ->write('$file = fopen(')
                ->subcompile($this->getNode('name'))
                ->write(', "w") or die("Unable to open file!");')
                ->write('fwrite($file, $content);')
                ->write('fclose($file);')
                ->write('echo("Created ".')
                ->subcompile($this->getNode('name'))
                ->write('."\n");');
        } else {
        	$compiler
                ->addDebugInfo($this)
                ->write('$file = fopen(')
                ->subcompile($this->getNode('name'))
                ->write(', "w") or die("Unable to open file!");')
    			->write('fwrite($file, ')
    			->subcompile($this->getNode('expression'))
    			->write(');')
    			->write('fclose($file);')
    			->write('echo("Created ".')
    			->subcompile($this->getNode('name'))
    			->write('."\n");');
        }
    }
}

class Twig_TokenParser_File extends Twig_TokenParser
{
    public function parse(Twig_Token $token)
    {
    	$parser = $this->parser;
        $stream = $parser->getStream();

        $name = $parser->getExpressionParser()->parseExpression();
        if ($stream->test(Twig_Token::OPERATOR_TYPE, '=')) {
            $stream->expect(Twig_Token::OPERATOR_TYPE, '=');
            $expression = $parser->getExpressionParser()->parseExpression();
            $stream->expect(Twig_Token::BLOCK_END_TYPE);
        } else {
            $stream->expect(Twig_Token::BLOCK_END_TYPE);
            $body = $this->parser->subparse(array($this, 'decideFileEnd'), true);
        }
        
        return new Twig_Node_File($name, $expression, $body, $token->getLine(), $this->getTag());
    }

    public function decideFileEnd(Twig_Token $token)
    {
        return $token->test('endfile');
    }

    public function getTag()
    {
        return 'file';
    }
}

$twig->addTokenParser(new Twig_TokenParser_File());
echo $twig->render('models.template');

?>