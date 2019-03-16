# ssh-ident identities

Create a directory for each identity, for example:
    $ mkdir -p ~/.ssh/identities/personal
    $ mkdir -p ~/.ssh/identities/work
    $ mkdir -p ~/.ssh/identities/secret

Generate (or copy) keys for those identities:
    # Default keys are for my personal account
    $ cp ~/.ssh/id_rsa* ~/.ssh/identities/personal
    # Generate keys to be used for work only, rsa
    $ ssh-keygen -t rsa -b 4096 -f ~/.ssh/identities/work/id_rsa
