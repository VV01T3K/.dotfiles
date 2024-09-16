sudo nix-collect-garbage
sudo nix-collect-garbage -d
nix-store --optimise
echo "System garbage collection done."