### Rails starter app template

The fully customizable `starter.rb` template script and the helper methods that come with it are intented to help you to always generate new rails apps with your preferred settings.
It also lets you to automate the first commit.

**Usage**

You may customize the `starter.rb` script using helper methods available in the `helpers` directory.
You could also use the many methods found at the below links. 

* [Helper methods from rails generators](http://api.rubyonrails.org/classes/Rails/Generators/Actions.html)
* [Helper methods from thor](http://www.rubydoc.info/github/wycats/thor/Thor/Actions)


Then use the `starter.rb` script like below when creating a new rails app. 

```
rails new NewProject -m /path/to/starter.rb
```

**Testing**

While customizing the script the `test.sh` can help you to test it. Use it like below.

```
bash test.sh

```
