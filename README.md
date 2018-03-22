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
