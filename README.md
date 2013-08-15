# MathJax-Rails

Use if you want headjs style loading

We are living in an age, where displaying math on web pages is never hard, thanks to the great work of [MathJax](https://github.com/mathjax/MathJax).

To quote the description from its official website,

  > [MathJax](https://github.com/mathjax/MathJax) is an open source JavaScript display engine for mathematics that works in all modern browsers.
  >
  > No more setup for readers. No more browser plugins. No more font installations… It just works.

## Why bother another gem?

Integrating MathJax into a rails project however could be a pain. MathJax is HUGE. It makes your project folder swollen very much, because of the excessive amount of files contained in this package. Including mathjax inside your developing directory makes your TextMate less responsive, because when TextMate loses focus and then regains focus, it will scan the whole directory structure for change.

Another problem is, where to put? Put into `public` does not seem the best practice, since beginning with rails 3.1 `public` is by default ignored in production environment. Plus it is big, when using git, it leaves you no choice but to throw mathjax inside .gitignore, which makes sharing across developers less painless.

## So?

That's the time when mathjax-rails comes into play!

* It maintains MathJax at a system-wide directory.
* By simply including mathjax-rails in your Gemfile, all your rails app can benefit from MathJax immediately.
* You can control the version of MathJax by controlling the version of mathjax-rails, which is done simply via bundler.

## Which version of MathJax does it use?

We maintain mathjax-rails to always use the latest version of stable MathJax realeases.

To see the actual version, check the constant Mathjax::Rails::MATHJAXVERSION.

## Usage

add this line to your Gemfile

	gem 'mathjax-rails', :git => 'git://github.com/itsgg/mathjax-rails.git'

then

	$ bundle install

add the script tag inside app/views/layouts/application.html.erb

``` rhtml
<%= mathjax_tag %>
```
and it is done!

To try it, write a simple formula, for example,

	\[\int_a^b f(x) dx=F(b)-F(a)\]

## Configuration

By default the `TeX-AMS_HTML-full.js` is loaded as the configuration file.

If you do not want any configuration file to be loaded:

``` rhtml
<%= mathjax_tag :config=>false %>
```
If you want to load another configuration file, say `Accessible-full.js`:

``` rhtml
<%= mathjax_tag :config=>'Accessible-full.js' %>
```
Additional configuration can be added directly before mathjax_tag, for example:

``` rhtml
<script type="text/x-mathjax-config">
	MathJax.Hub.Config({
	 tex2jax: {
	   inlineMath: [ ['$','$'] ],
	   processEscapes: true
	 }
	});
</script>
<%= mathjax_tag %>
```

For more options please consult the MathJax documentation.

## What did it do to my rails project

One thing: 1 helper method `mathjax_tag`.

## Note

If you have a fast CDN service at hand, you don't need this gem.

Putting your MathJax at CDN is probably the best choice.

By `dmarczal`,

To work in rails 3.1 on production environment wih ngnix I just comment the follow line in production.rb

```
#config/environments/production.rb
#config.action_dispatch.x_sendfile_header = "X-Sendfile"
```

## ChangeLog
* 2013.8.15
Changed to use headjs by default and load mml and latex

* 2013.7.3
Convert to Rails Engine.

* 2013.6.1
Update MathJax to 2.2

* 2011.7.28
Version 0.0.2 used to fail on Heroku. Now the problem is fixed. I used to use `send_file` without content_type, which causes a failure when deployed to Heroku. Now in version 0.0.3 I use `render :type=>...,` with the appropriate content-type set and the problem is solved.
