package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class MenuState extends FlxState
{
	private var player:FlxSprite;
	private var cameraGuide:FlxSprite;
	private var tilemap:FlxTilemap;
	
	override public function create():Void
	{
		super.create();
		
		//	Cargo el nivel de OGMO a un Tilemap
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		
		//	Seteo reglas para las colisiones
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.NONE);
		tilemap.setTileProperties(2, FlxObject.ANY);
		
		//	Cargo cada entidad del nivel de OGMO y inicializo sus cosillas
		loader.loadEntities(entityCreator, "entities");
		
		//	Seteo los límites de scrolleo para la cámara, y para las colisiones en el mundo
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		
		//	Seteo el guía de la cámara, a quien ésta sigue
		cameraGuide = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		cameraGuide.makeGraphic(1, 1, 0x00000000);
		cameraGuide.velocity.x = 50;
		FlxG.camera.follow(cameraGuide);
		player.velocity.x = cameraGuide.velocity.x;	
		
		//	Agrego todo al FlxState
		add(cameraGuide);
		add(tilemap);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//	Esto ya basta para que el player colisiones con los tiles, respetando las reglas que antes seteamos.
		FlxG.collide(tilemap, player);
	}
	
	/*
	 * Esta función se llama una vez para cada entidad en el nivel de OGMO desde el loadEntities del loader.
	 * Por cada vez que entra aquí, se setean los datos de una entidad nueva.
	 * Si tengo 25 enemigos en mi nivel, esta función se ejecuta 25 veces y crea las entidades,
	 * poniendo luego a cada uno sus datos.
	 * Es enteramente customizable para lo que se quiere hacer en la inicialización de cada objeto.
	 */
	private function entityCreator(entityName:String, entityData:Xml):Void
	{
		//	Parseo la X y la Y de cada entidad en el nivel de OGMO
		var entityStartX:Float = Std.parseFloat(entityData.get("x"));
		var entityStartY:Float = Std.parseFloat(entityData.get("y"));
		
		//	Me fijo qué tipo de entidad tengo que inicializar...
		switch(entityName)
		{
			//	...y creo la entidad y seteo sus cosillas.
			case "player":
				player = new FlxSprite(entityStartX, entityStartY);
				player.makeGraphic(16, 16, 0xFFFF0000);
		}
	}
}
