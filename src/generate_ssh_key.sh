mkdir -p keys

if [ ! -f keys/key.pub ]; then
  ssh-keygen -q -N "" -C "Benkins CI" -f keys/key
  echo "SSH Key was generated. Add the following key to resources Benkins needs access to. Then run this command again."
  echo ""
  cat keys/key.pub
  exit 1
fi
