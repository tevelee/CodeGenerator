# Easy Code Generation

This repository contains a lightweight - yet powerful - approach to deal with language-independent code generation. 
As I'm an iOS engineer, I primarily work with Objective-C and Swift code in my day-to-day work, so most of the examples are iOS related snippets.

## Why templates?

Why use a template engine when you have a bunch of professional generators like [Remodel](https://github.com/facebook/remodel) from Facebook or [json2swift](https://github.com/viteinfinite/json2swift) or [SwiftGen](https://github.com/AliSoftware/SwiftGen) or ... (the list is long).

The answer in short: the ability to customize the output. 

What I like about templates is that you are the one who write them.
If you don't like something you can easily modify *anything*, and cusomtize the generated code in a way that it matches your own style, your company coding-style and principles, just about the way you want them to look.

It gives you freedom and an easy way to extend or modify or tweak the most important thing: the output.

## Motivation

My primary interest was around metaprogramming: 
how can I programmatically alter the compiler to extend my codebase without me adding those extensions repetatively. 
The main focus was to make the life of the developer easier with added useful code snippets in a way that it doesn't alter the runtime or the performance of the program in any ways, so doing the work between the code-writing and the compilation.

First I was thinking of the most basic additions like model hashing, copying operations and equality checks based on the simplest inputs: their properties. 
Maybe some model parsing from JSON objects, or later on generating their [lens](https://hackage.haskell.org/package/lens) property setters.

I had several iterations on the problem, tried extending the compiler, organizing the code in a way to support generic extensions so I could somewhat imitate the feeling of metaprogramming. 
Finally I realized that code generation seems to be the most lightweight and powerful solution. Sometime the simplest solution is the easiest one (not always tho).

As a workaround to the model-property problem, previously I wrote some runtime magic placed in a model baseclass for equality, hashing, copying and similar operations which read the active properties and with a for it loop on them it did the trick.
This turned out to be a very expensive trick, slowed down the runtime most than I expected them to do. 
For this reason I decided to leave the runtime out of the solution, doing all the heavy work at compile-time.

## About metaprogramming

I realized that the iOS dev environment is full of metaprogramming solutions already.
Turned out [I wasn't the only one](http://genius.com/Soroush-khanlou-metaprogramming-isnt-a-scary-word-not-even-in-objective-c-annotated). 

Probably @synthesize is the most obvious example, it generates getters and setters for your instance variables you defined as @properties with pre-defined options (copying, atomicity, weakness, etc.). 
Just to mention some more of them: key-value coding, @dynamic properties, 
Swift generics or protocol extensions are all somewhat extending your code without you explicitely writing the repetative work yourself.

## Usage

After you wrote your template, you should modify the last line of `index.php` accordingly: `echo $twig->render('models.template');`, unless you modified the name of the default `models.template` file.

For the templaes I used the excellent [Twig](http://twig.sensiolabs.org/doc/templates.html) template engine. 
I was looking for something that is a language-independent templating system, and the closest I found was Twig. 
It's largely optimized for web and be used in php environments, but turning off a couple of optimizations, like caching, made my life much easier. 

To start the generation, simply run `php index.php`. 
The output will tell you the names of the generated files.

As for the syntax of the templates, I'm solely using the syntax provided by Twig, with one little addition. 
I added a custom `file` tag (see the examples) which takes the output and saves it into a text file. 
This makes the code generation persistent, that not only you have the output in the console, but you have it persisted on your disk as well.

## Input/Output examples

### Model generation example

As I mentioned my primary interest was in code generation. 
And to validate the idea, I started up with the obvious DTO and data-model generators.

Let's see the template below

```
{% import "objc.template" as objc %}
{{ objc.Model("Address", [
	{"name": "postalCode", "type": "NSNumber*"},
	{"name": "streetAddress", "type": "NSString*"},
	{"name": "number", "type": "NSInteger"}
], features) }}
```

and it's output here:

* [Address.h](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/Address.h)
* [Address.m](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/Address.m)

Another model using the newly created `Address` above:

```
{{ objc.Model("Person", [
	{"name": "firstName", "type": "NSString*"},
	{"name": "lastName", "type": "NSString*"},
	{"name": "nickName", "type": "NSString*"},
	{"name": "age", "type": "NSInteger"},
	{"name": "address", "type": "Address*"}
], features, ["\"Address.h\""]) }}
```

and the result:

* [Person.h](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/Person.h)
* [Person.m](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/Address.m)

As you minght noticed, I included a `features` property in each of the model factories. 
I only have those to separate all the different options of model generation, like hashing, equality, initialisers, immutable properties, NSCopying, NSCoding and so on.
The options are limitless.
So actually to work you'll need the features defined something as

```
{% set features = [
	"ImmutableProperties", 
	"Initializer", 
	"NSCoding", 
	"NSCopying", 
	"Description", 
	"Equality", 
	"Hashing", 
	"Builder", 
	"Lenses", 
	"JSONCoding"
] %}
```

So actually if you included a `builder` feature, you'll have additional builder classes generated:

* [AddressBuilder.h](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/AddressBuilder.h)
* [AddressBuilder.m](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/AddressBuilder.m)
* [PersonBuilder.h](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/PersonBuilder.h)
* [PersonBuilder.m](https://github.com/tevelee/CodeGenerator/blob/master/output/objc/AddressBuilder.m)

### Swift

I included another language to generate model files in: Swift.
So a similar definition

```
{% import "swift.template" as swift %}
{{ swift.Model("Address", [
	{"name": "postalCode", "type": "Int"},
	{"name": "streetAddress", "type": "String"},
	{"name": "number", "type": "Int"}
], features) }}

{{ swift.Model("Person", [
	{"name": "firstName", "type": "String"},
	{"name": "lastName", "type": "String"},
	{"name": "nickName", "type": "String"},
	{"name": "age", "type": "Int"},
	{"name": "address", "type": "Address", "custom": true}
], features) }}

{{ swift.Model("Record", [
	{"name": "name", "type": "String"},
	{"name": "creator", "type": "Person", "custom": true},
	{"name": "date", "type": "Date"}
], features) }}
```

generates the following:

* [Address.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/Address.swift)
* [Person.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/Person.swift)
* [Record.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/Record.swift)

If you enabled the `builder` feature, then additionally

* [AddressBuilder.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/AddressBuilder.swift)
* [PersonBuilder.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/PersonBuilder.swift)
* [RecordBuilder.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/RecordBuilder.swift)

or with the `lenses` feature

* [AddressLenses.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/AddressLenses.swift)
* [PersonLenses.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/PersonLenses.swift)
* [RecordLenses.swift](https://github.com/tevelee/CodeGenerator/blob/master/output/swift/RecordLenses.swift)

output files as well. 

### Details

If you're interested in the actual templates that create the classes themselves (not just the "high-level" model definition interface), you're free to look at [swift.template](https://github.com/tevelee/CodeGenerator/blob/master/templates/swift.template) and [objc.template](https://github.com/tevelee/CodeGenerator/blob/master/templates/objc.template).
Here you can also customize the output as you like as these are just simple text files, there's nothing to compile. 
Again, the syntax is provided by the template engine Twig. Check out its docs [here](http://twig.sensiolabs.org/doc/templates.html). 
These files are really just a few hundred lines long, and contain *all* the necessary information to generate all the example models above.
Really concise, extremely powerful.

You'll see simple things like 

```
{% macro ImplementationFile(name, imports, properties, content, global) %}

	{% for import in imports %}
	#import {{import|raw}}
	{% endfor %}
	
	{{global}}
	
	@implementation {{name}}
	
		{{content}}
	
	@end

{% endmacro %}
```

or 

```
{% macro EqualityExtension(name, properties) %}

	func ==(lhs: {{name}}, rhs: {{name}}) -> Bool {
	    return {% for property in properties %}lhs.{{property.name}} == rhs.{{property.name}}{% if not loop.last %} && {% endif %}{% endfor %}
	}
	
	extension {{name}} : Equatable {
	}
	
{% endmacro %}
```

It's easy to wrap your head around.

## Future plans

For the model generation templates there are countless options and features to pack, like JSON parsing, paraterization, different immutable setters, or some cool features from [Remodel](https://github.com/facebook/remodel). 

A couple of other areas that I had in mind are client-side SDK generation, advanced enumeration classes (like string-enums in Objective-C), basically any repetative task from our day-to-day developer work.

I found a couple of useful examples since and used them already for code/text generation, like different forms of serialization or repetative text creation as well.

## License

This repository was brought to life by László Teveli. 
The main engine behind the scenes is [Twig](http://twig.sensiolabs.org/doc/templates.html), created by SensioLabs.

Any form of modification or redistribution is free and allowed by the author. 
If you happen to use it for something interesting, I'd appreciate an e-mail though ;-)
The repo contains only an experiment to overcome the repetative tasks in my work. 
I'm sharing it because someone else might also find it useful.

If you like the idea or have further improvements in your mind, feel free to contact me at [tevelee@gmail.com](mailto:tevelee@gmail.com) or submit an issue or pull request and I'll be happy to take it from there.