dune build @runtest @default --auto-promote
./scripts/deploy.sh
git add .
git commit -a -m '.'
git push 
cd deploy
git add .
git commit -a -m '.'
git push 
