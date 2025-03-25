cd /var/www/empiresec.co/

# Pull the latest changes from Github
git pull origin main
# Build the clearnet static site
hugo --config ip.yml

# Build the Tor static site
hugo --config tor.yml

hugo --config i2p.yml

# Compress the clearnet static site
cd /var/www/empiresec.co/public

~/.local/share/neocities/bashcities --profile new_profile --no-git push

for file in $(find . -type f)
do
    zopfli "$file"
    rm "$file"
    touch -r "$file".gz "$file"
done

# Compress the Tor static site
cd /var/www/empiresec.co/tor
for file in $(find . -type f)
do
    zopfli "$file"
    rm "$file"
    touch -r "$file".gz "$file"
done
cd ~
