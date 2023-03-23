
function clearShell(){
    ICyan='\033[0;31m'
    White='\033[0;37m'        # White
clear 
echo Bienvenue dans mkMakefile le créateur de makefile
echo -e "\n${ICyan}"
echo -e "          __        _____            __              _____ .__ .__            " ;
echo "  _____  |  | __   /     \  _____   |  | __  ____  _/ ____\|__||  |    ____   " ;
echo " /     \ |  |/ /  /  \ /  \ \__  \  |  |/ /_/ __ \ \   __\ |  ||  |  _/ __ \  " ;
echo "|  Y Y  \|    <  /    Y    \ / __ \_|    < \  ___/  |  |   |  ||  |__\  ___/  " ;
echo "|__|_|__/|__|__\ \____|____/(______/|__|__\ \_____> |__|   |__||____/ \_____> " ;
#echo "                                         \/                                 " ;
#echo "  ##   ##  ##  ##   ###  ##  #######             ####   #### ##  #######  ##  ##    ####     #####   #### ## " ;
echo -e "${White}"
echo -e "\n"
}

function afficherPojet(){
    #Red='\033[0;31m'  
    Red='\033[1;32m'
    White='\033[0;37m' 
    Black='\033[0;31m'        # Black
    On_IWhite='\033[0;107m'   # White     
    Color_Off='\033[0m'

    echo -e "${Black}"  
    echo "------------------------------------------------"
    echo -e "Nom du projet : ${Red} $nomProjet ${Black}"
    echo -e "Auteur : ${Red} $auteur ${Black}"
    echo -e "Version : ${Red} $version ${Black}"
    echo -e "Description : ${Red} $description ${Black}"
    echo "------------------------------------------------"
    echo -e "${Color_Off}\n"
}

function signaturemain(){
    echo "/*************************************************" >> $path/$nomProjet/main.c
    echo " * Nom du projet : $nomProjet" >> $path/$nomProjet/main.c
    echo " * Auteur : $auteur" >> $path/$nomProjet/main.c
    echo " * Version : $version" >> $path/$nomProjet/main.c
    echo " * Description : $description" >> $path/$nomProjet/main.c
    echo "*************************************************/" >> $path/$nomProjet/main.c
    echo -e "\n" >> $path/$nomProjet/main.c
    echo "#include <stdio.h>" >> $path/$nomProjet/main.c
    echo "#include <stdlib.h>" >> $path/$nomProjet/main.c
    echo -e "\n" >> $path/$nomProjet/main.c
    echo "int main(int argc, char *argv[])" >> $path/$nomProjet/main.c
    echo "{" >> $path/$nomProjet/main.c
    echo "    return 0;" >> $path/$nomProjet/main.c
    echo "}" >> $path/$nomProjet/main.c

}


function ecrireMakeFile(){

echo "c = gcc" >> $path/$nomProjet/Makefile
echo "op=-Wall -Wextra" >> $path/$nomProjet/Makefile
echo -e "\n" >> $path/$nomProjet/Makefile
echo -e "$allFiles" >> $path/$nomProjet/Makefile
echo -e "\t$compilMain $endCompilMain" >> $path/$nomProjet/Makefile

echo -e "$autresFicCompil" >> $path/$nomProjet/Makefile

}


function finScript(){
    echo "Merci d'avoir utilisé mkMakefile en espérant que vous avez apprécié ! Bonne séance de code !" 
    echo "------------------------------------------------"
    echo -e "\n"
}

#creer des fonctions avec shell
#lire les todos
#faire un makefile

# $# = nombre d'arguments
# $1 = premier argument
# $@ = tous les arguments
# $0 = nom du script



if [ $1 = "--help" ] || [ $1 = "--h" ]; then
    echo "mkMakefile est un script qui permet de créer un projet en C avec un Makefile"
    echo "--help ou --h : Affiche l'aide"
    echo "--version ou --v : Affiche la version du script"
    echo "-todo : Affiche les TODO du projet"



elif [ $1 = "--version" ] || [ $1 = "--v" ]; then
    echo "mkMakefile version 1.0.0"


elif [ $1 = "-todo" ]; then
rm -rf todo.txt
echo "TODO :" >> todo.txt
grep -r "[Tt][oO][dD][oO]" $2 > todo.txt
echo "TODO ajouté au fichier todo.txt"
    



else





clearShell


echo "Veuillez entrer le nom du projet :"
read nomProjet

clearShell
echo "Par défaut l'auteur du projet est $(whoami)"
echo "Voulez-vous changer l'auteur ? (o/n)"
read choixAuteur
if [ "$choixAuteur" = "o" ]; then
    echo "Veuillez entrer le nom de l'auteur :"
    read auteur
else
    auteur=$(whoami)
fi

clearShell
echo "Veuillez entrer la version du projet :"
read version

clearShell
echo "Veuillez entrer la description du projet :"
read description

clearShell
afficherPojet
echo "Par défaut le projet va se créer dans $(pwd)"
echo "Voulez-vous changer le chemin ? (o/n)"
read choixPath
if [ "$choixAuteur" = "o" ]; then
    echo "Veuillez entrer le nom de l'auteur :"
    read path
else
    path=$(pwd)
fi
clearShell
afficherPojet

mkdir $path/$nomProjet
touch $path/$nomProjet/Makefile
touch $path/$nomProjet/main.c



allFiles="all : main.c"
compilMain="\$(c) \$(op)"
endCompilMain="main.c -o $nomProjet"
autresFicCompil=""


signaturemain




echo "mkMakefile a créé un main.c voulez vous ajouter d'autres fichier ? (o/n)"
read choixFichier

while [ "$choixFichier" = "o" ]; do
    echo "Veuillez entrer le nom du fichier :"
    read fichier
    touch $path/$nomProjet/$fichier.c
    touch $path/$nomProjet/$fichier.h
    allFiles="$allFiles $fichier.o"
    compilMain="$compilMain $fichier.o"
    autresFicCompil="$autresFicCompil \n$fichier.o : $fichier.c $fichier.h \n\t\$(c) \$(op) -c $fichier.c"
    echo "Voulez vous ajouter d'autres fichier ? (o/n)"
    read choixFichier
done


ecrireMakeFile






finScript
fi