/**
* Part of Source for The Game.
* Developed by @Tggtt for the community at https://recess.fandom.com
* Licensed as CC-by-SA-4.0.
*/

package;


import motion.Actuate;
import openfl.display.GraphicsBitmapFill;
import openfl.display.IGraphicsData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import openfl.Vector;
import openfl.geom.Matrix;

class Main extends Sprite
{	
	
	private var tile:Null<AJTile>;
	
	private var cacheOffsetX:Float;
	private var cacheOffsetY:Float;
	
	
	public function new()
	{
		
		super();
		
		for (i in 1...8)
		{
			tile = new AJTile(i);
			tile.x = 100 + i*60;
			tile.y = 300;
			tile.buttonMode = true;
			addChild (tile);
			tile.addEventListener (MouseEvent.MOUSE_DOWN, tile_onMouseDown);
			tile.addEventListener (MouseEvent.MOUSE_WHEEL, tile_onMouseAlt);
			tile.addEventListener (MouseEvent.RIGHT_CLICK, tile_onMouseAlt);
		}		

		this.stage.color = 0x7e868f;
		
	}
	
	private function tile_onMouseDown (event:MouseEvent):Void
	{
		if (Std.isOfType(event.currentTarget, AJTile))
		{
			tile = cast(event.currentTarget, AJTile);
			this.setChildIndex(tile , numChildren -1);
		}
		
		cacheOffsetX = tile.x - event.stageX;
		cacheOffsetY = tile.y - event.stageY;
		
		stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		
	}

	private function tile_onMouseAlt (event:MouseEvent):Void
	{
		if (Std.isOfType(event.currentTarget, AJTile))
		{
			var rtile : AJTile = cast(event.currentTarget, AJTile);
			this.setChildIndex(rtile , numChildren -1);
			rtile.invertRotated();
			rtile.updateRotated();
		}
	}
	
	
	private function stage_onMouseMove (event:MouseEvent):Void
	{
		
		tile.x = event.stageX + cacheOffsetX;
		tile.y = event.stageY + cacheOffsetY;
		
	}
	
	private static inline var tileWidth : Int = 185-19*2;
	private static inline var tileHeight : Int = 242-22*2;
	private function stage_onMouseUp (event:MouseEvent):Void
	{
		{
			var xPosition : Float =  tileWidth * Std.int(tile.x/tileWidth);
			var yPosition : Float =  tileHeight * Std.int(tile.y/tileHeight);

			if ((xPosition >= 0) && (xPosition < this.stage.stageWidth) && (yPosition >=0) && (yPosition < this.stage.stageHeight))
				Actuate.tween (tile, 1, { x: xPosition, y: yPosition } );
			else
				Actuate.tween (tile, 1, { x: 0, y: 0 } );
		}
		
		stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
	}
	
	
}
