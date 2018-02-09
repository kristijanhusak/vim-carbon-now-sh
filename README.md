# vim-carbon-now-sh

(n)vim implementation plugin for opening selected content in [https://carbon.now.sh](https://carbon.now.sh).


## Usage

Select some text in visual mode and type this:
```vimL
:call CarbonNowSh()
```

You can also map it to something, just make sure it starts with `:`

```vimL
vnoremap <F5> :call CarbonNowSh()
```
