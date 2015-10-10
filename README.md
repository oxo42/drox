# drox
Dot Repository for Ox

# Install

This goes into the end of .bashrc

```bash
if hash git ; then 
    if [ -f ~/.drox/bashrc ] ; then 
        # Start the update script silently in the background and send logs to /tmp/droxlog
        (cd ~/.drox && ./update.sh >> /tmp/droxlog 2>&1 &)
        # Source the bashrc and continue so the shell is useable now
        source ~/.drox/bashrc
    else
        (wget -q -O - https://raw.githubusercontent.com/oxo42/drox/master/install.sh | bash >> /tmp/droxlog 2>&1 &)
    fi
fi
```
