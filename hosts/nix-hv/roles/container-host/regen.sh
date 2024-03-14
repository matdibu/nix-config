#!/usr/bin/env nix
#! nix shell github:aksiksi/compose2nix nixpkgs#bash --command bash

containers=(
    qbittorrent
    jellyfin
)

for container in "${containers[@]}"; do
    compose2nix \
        -project nix-containers \
        -runtime podman \
        -inputs containers/"${container}"/compose.yaml \
        -output containers/"${container}"/auto-generated.nix
done

