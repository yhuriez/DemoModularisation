#!/bin/bash

# Script pour exécuter build_runner dans tous les packages
# Couleurs pour l'affichage
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Exécution de build_runner sur tous les packages${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Compteur de packages traités
total=0
success=0
failed=0

# Parcourir tous les sous-dossiers du dossier packages/
for package_dir in packages/*/ ; do
    # Vérifier si le dossier contient un pubspec.yaml
    if [ -f "${package_dir}pubspec.yaml" ]; then
        package_name=$(basename "$package_dir")
        total=$((total + 1))
        
        echo -e "${BLUE}📦 Traitement du package: ${package_name}${NC}"
        
        # Se déplacer dans le dossier du package
        cd "$package_dir" || continue
        
        # Exécuter build_runner
        if dart run build_runner build --delete-conflicting-outputs; then
            echo -e "${GREEN}✅ $package_name: build_runner exécuté avec succès${NC}\n"
            success=$((success + 1))
        else
            echo -e "${RED}❌ $package_name: échec de l'exécution de build_runner${NC}\n"
            failed=$((failed + 1))
        fi
        
        # Retourner à la racine
        cd - > /dev/null || exit
    fi
done

# Résumé
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Résumé de l'exécution${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "Total de packages traités: ${total}"
echo -e "${GREEN}Succès: ${success}${NC}"
if [ $failed -gt 0 ]; then
    echo -e "${RED}Échecs: ${failed}${NC}"
fi
echo -e "${BLUE}========================================${NC}"

