# drox
Dot Repository for Ox

# Linux Install

## .bashrc

```bash
if [ -f ~/.drox/bashrc ] ; then
    # Source the bashrc and continue so the shell is useable now
    source ~/.drox/bashrc
fi
```

## .profile

```bash
# Install or update https://github.com/oxo42/drox
if hash git ; then
    if [ -d ~/.drox ] ; then
        # Start the update script silently in the background and send logs to /tmp/droxlog
        (cd ~/.drox && ./update.sh 2>&1 &) >> /tmp/droxlog
    else
        (curl https://raw.githubusercontent.com/oxo42/drox/master/install.sh | bash 2>&1 &) >> /tmp/droxlog
    fi
fi
```


I do the install in my `.profile` because I want to push it out over puppet.  That way on my first login, my profile gets set up.


# Windows Install

Windows **WHAT**.  PowerShell huh? .gitconfig?  .vim?  Cats and dogs living together?  MADNESS I TELL YOU, MADNESS!!

```PowerShell
(new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/oxo42/drox/master/Install-Drox.ps1") | iex
```
