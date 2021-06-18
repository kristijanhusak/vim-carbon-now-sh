# vim-carbon-now-sh

(n)vim implementation plugin for opening selected content in [https://carbon.now.sh](https://carbon.now.sh).

## Installation

### Vundle

Add the following line to your `.vimrc`

```vimL
Plugin 'kristijanhusak/vim-carbon-now-sh'
```

Then run the following in Vim:

```
:source %
:PluginInstall
```

## Usage

Select some text in visual mode and run this command:
```vimL
:CarbonNowSh
```

You can also map it to something and use it after selection:

```vimL
vnoremap <F5> :CarbonNowSh<CR>
```

### Alternate Endpoint
To send your code snippets to a local instance of carbon.now instead of the public, shared site
(e.g. if you're doing private development, your code is internal, etc.), pass in an alternate
base URL via your Vim config:

```vimL
let g:carbon_now_sh_base_url = 'http://localhost:3000'
```

### Browser
Plugin will try it's best to use your default browser. If it fails, or you want to customize it,
provide browser executable through this option to your vimrc. Example for google-chrome:

```vimL
let g:carbon_now_sh_browser = 'google-chrome'
```

### Options
You can set the query string that will be passed to [https://carbon.now.sh](https://carbon.now.sh).
Example for setting font and line number:

```vimL
let g:carbon_now_sh_options =
\ { 'ln': 'true',
  \ 'fm': 'Source Code Pro' }
```
