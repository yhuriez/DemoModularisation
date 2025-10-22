#!/bin/bash

# Script de génération du code pour tous les packages
# Utilise build_runner avec injectable_generator

echo "🚀 Début de la génération du code..."
echo ""

# Couleurs pour les messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour générer le code d'un package
generate_package() {
    local package_name=$1
    local package_path=$2
    local is_flutter=$3
    
    echo -e "${BLUE}📦 Génération pour $package_name...${NC}"
    cd "$package_path" || exit
    
    if [ "$is_flutter" = true ]; then
        flutter pub run build_runner build --delete-conflicting-outputs
    else
        dart run build_runner build --delete-conflicting-outputs
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $package_name généré avec succès${NC}"
    else
        echo "❌ Erreur lors de la génération de $package_name"
        exit 1
    fi
    
    cd - > /dev/null || exit
    echo ""
}

# Récupération des dépendances
echo -e "${BLUE}📥 Récupération des dépendances...${NC}"
flutter pub get
echo ""

# Génération pour chaque package
generate_package "common" "packages/common" false
generate_package "data" "packages/data" true
generate_package "feature_auth" "packages/feature_auth" true
generate_package "main app" "." true

echo -e "${GREEN}🎉 Génération terminée avec succès !${NC}"
echo ""
echo "Vous pouvez maintenant lancer l'application avec:"
echo "  flutter run"

