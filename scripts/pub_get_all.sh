#!/bin/bash

# Script pour exécuter flutter pub get dans tous les packages
# Couleurs pour l'affichage
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Exécution de flutter pub get sur tous les packages${NC}"
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
        
        # Exécuter flutter pub get
        if flutter pub get; then
            echo -e "${GREEN}✅ $package_name: dépendances récupérées avec succès${NC}\n"
            success=$((success + 1))
        else
            echo -e "${RED}❌ $package_name: échec de la récupération des dépendances${NC}\n"
            failed=$((failed + 1))
        fi
        
        # Retourner à la racine
        cd - > /dev/null || exit
    fi
done

# Exécuter flutter pub get à la racine du projet
echo -e "${BLUE}📦 Traitement du projet principal${NC}"
if flutter pub get; then
    echo -e "${GREEN}✅ Projet principal: dépendances récupérées avec succès${NC}\n"
    total=$((total + 1))
    success=$((success + 1))
else
    echo -e "${RED}❌ Projet principal: échec de la récupération des dépendances${NC}\n"
    total=$((total + 1))
    failed=$((failed + 1))
fi

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

