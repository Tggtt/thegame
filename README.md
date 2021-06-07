# TheGame
The Game Source Repository.

## Description

This is the source for code and assets for the game developed as an implementation for Ajimbo.
Ajimbo is a fictional game that appeared in Recess. No one knows how to play due to lack of details.

You can run the public release build at: https://tggtt.github.io/TheGame/

See more details on the release page: https://recess.fandom.com/wiki/User_blog:Tggtt/The_Game_is_Released!

## Building The Game
This is a Haxe project that uses Lime and OpenFL.
To build, first install Haxe and Haxelib.
Use Haxelib to install Lime and OpenFL.
> haxelib install lime
> haxelib install openfl

Afterwards, change directory to the repository root and run haxelib to build.
> haxelib run openfl build TheGame html5
> haxelib run openfl deploy TheGame html5

Given that html5 is the desired platform. "neko" and "flash" should also work if you have the proper libraries installed. Other platforms were not tested.

Thanks for your interest!
Tggtt.
