# ✅ Pragma-Validators
A set of declarative validators for Pharo accessors, inspired by JSR-380 Java Bean Validation annotations.

## 🪄 Usage in a nutshell
1. Make a class, declare several inst vars and generate their corresponsing accessors.
```smalltalk
Object subclass: #RegistrationRequest
    instanceVariableNames: 'username name password emails'
    classVariableNames: ''
    package: 'MyApplication-DataTransfer'
```

2. Annotate the accessors with desired validators. <sup>1),2)</sup>

2.1 Simple validation
```smalltalk
username
    <validateAs: 'string'> "should be a string"
    <validateAs: 'notBlank'> "notBlank ~ should not be an empty string or whitespace"
    ^ username
```
2.2 Collection validation (note that ALL collection elements must conform to the declared validation pragmas)
```smalltalk
emails
    <validateAs: '#string'>
    <validateAs: '#email'> "the '#' signifies that emails shoule be a collection"
                           "the 'email' signifies that each element of the collection"
                           "should be a string containing a valid email"
    ^ emails
```
	
3. Validate the object once filled. If the validations find a problem, `PragmaValidationError` will be raised.
```smalltalk
| r |
r := RegistrationRequest new username: 'john'; emails: {'john@smalltalk.com'. 'jsmith@acme.com'}; validate.
```

1) Note that annotating a mutator or an accessor with a protocol different than "accessing" will not work.

2)The accessors are called in the process of validation, thus one must add additional code to them with caution.

## 📑 Supported validations

| Validation       | Usage Example                    | Description                                                                                    |
|------------------|----------------------------------|------------------------------------------------------------------------------------------------|
| `notNil`         | `<validateAs: 'notNil'>`         | Accessor value is not nil                                                                      |
| `assertTrue`     | `<validateAs: 'assertTrue'>`     | Accessor value                                                                                 |
| `size:MIN,MAX`   | `<validateAs: 'size:1,3'>`       | Accessor value has a size between the attributes MIN and MAX; can be applied to any collection |
| `min:VAL`        | `<validateAs: 'min:100'>`        | Accessor value has a value no smaller than VAL                                                 |
| `max:VAL`        | `<validateAs: 'max:1000'>`       | Accessor value has a value no larger than VAL                                                  |
| `email`          | `<validateAs: 'email'>`          | Accessor value is a valid email address                                                        |
| `notEmpty`       | `<validateAs: 'notEmpty'>`       | Accessor value is not null or empty; can be applied to any collection                          |
| `notBlank`       | `<validateAs: 'notBlank'>`       | Accessor value is not null, empty string or string containing solely whitespace                |
| `positive`       | `<validateAs: 'positive'>`       | Accessor value is strictly positive number                                                     |
| `positiveOrZero` | `<validateAs: 'positiveOrZero'>` | Accessor value is strictly positive number, or 0                                               |
| `negative`       | `<validateAs: 'negative'>`       | Accessor value is strictly negative number                                                     |
| `negativeOrZero` | `<validateAs: 'negativeOrZero'>` | Accessor value is strictly negative number, or 0                                               |
| `datetimeString` | `<validateAs: 'datetimeString'>` | Accessor value is a string containing date and time                                            |
| `past`           | `<validateAs: 'past'>`           | Accessor value is a string containing date and time which is in the past                       |
| `future`         | `<validateAs: 'future'>`         | Accessor value is a string containing date and time which is in the future                     |

## 🎁 Installation
```smalltalk
Metacello new
    baseline: 'PragmaValidators';
    repository: 'github://radekbusa/Pragma-Validators';
    load.
```

## 🔌 Integration example
Let's say that we want to use the pragma validators for validating JSON request bodies in our RESTful API.

1. In a controller or a Teapot filter, write:
```smalltalk
| body parsedBody |
body := aRequest entity string.
parsedBody := NeoJSONReader fromString: body as: RegistrationRequest.
parsedBody validate. "will validate each incoming request body"
```

## 🧩 Compatibility
Tested in Pharo 7, 8 and 9.

## 👨‍💻 Author
Radek Busa is the author and maintainer of this project.
* Tech blog: [www.medium.com/@radekbusa](http://www.medium.com/@radekbusa)
* Hire me for your next Smalltalk project: [www.radekbusa.eu](http://www.radekbusa.eu)

> "I love building enterprise-grade software products in no time and Pharo greatly contributes to that with its amazing debugger, test-driven environment and other great stuff, such as refactoring tools. *My vision is to build libraries for ultra-productive enterprise microservice development with minimalistic and easy-to-grasp APIs for Smalltalk in 2020s.*"

If you endorse my vision and/or this project helped you, please don't hesitate to donate. Your donations will be welcome!

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate?hosted_button_id=Z5NNZTU7VASJQ)
