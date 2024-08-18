
$vimloc = "${env:LOCALAPPDATA}\nvim"
$makethisfolder = $vimloc + "\autoload"
$where = $makethisfolder + "\plug.vim"
$URL = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

New-Item -ItemType Directory $makethisfolder -Force
Invoke-WebRequest -URI $URL -OutFile $where
nvim --headless +PluginInstall +qall
