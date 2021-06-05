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
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.events.MouseEvent;
import openfl.display.SimpleButton;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

import openfl.Vector;
import openfl.geom.Matrix;

class Main extends Sprite
{	
	
	private var tile:Null<AJTile>;
	private var bookOpen:Null<Sprite>;
	private var bookClosed:Null<Sprite>;
	private var buttonEnter : Null<SimpleButton>;
	private var header: Null<TextField>;
	private var message: Null<TextField>;

	private static var warningText: Array<String> = ["This game is known to cause extreme addiction.",
			"We are not responsible if it causes aggressivity, rage, insomnia,",
			" loss of friends or lack of interest on other activities.",
			"Do not ask of help if someone you know",
			" becomes a zombie due to this game.",
			" ",
			"Please proceed with caution!",
			"You have been warned!"];
	private var warningTextField: Null<Array<TextField>>;
	private var cacheOffsetX:Float;
	private var cacheOffsetY:Float;
	
	
	public function new()
	{
		
		super();
		this.showMain();
	}

	private inline function showMain()
	{
		this.stage.color = 0x000000;
		this.buttonEnter = createButton("I can't beat them, might as well join them!");

		this.buttonEnter.x= Std.int((this.stage.stageWidth - this.buttonEnter.width)/2);
		this.buttonEnter.y= Std.int(this.stage.stageHeight - 50);
		this.buttonEnter.useHandCursor = true;

		this.addChild(this.buttonEnter);
		this.buttonEnter.addEventListener(MouseEvent.CLICK, buttonEnter_onMouseClick);

		this.header = new TextField();
		this.header.autoSize = (TextFieldAutoSize.CENTER);
		this.header.htmlText = ('<font size="48">' + "WARNING" + "</font>");
		this.header.background = true;
		this.header.backgroundColor = 0xF00000;
		this.header.border = false;
		this.header.x =  Std.int((this.stage.stageWidth - this.header.width)/2);
		this.header.y =  10;
		this.addChild(this.header);

		this.message = new TextField();
		this.message.autoSize = (TextFieldAutoSize.CENTER);
		this.message.htmlText = ("<font size=\"32\" color=\"#50F050\">You've come to join us, that is good.</font>");
		this.message.x = Std.int((this.stage.stageWidth - this.message.width)/2);
		this.message.y = this.buttonEnter.y - this.buttonEnter.height - 10;
		this.addChild(this.message);

		// separated because using <p> misaligns....
		{
			this.warningTextField = new Array<TextField>();
			var yPosition : Float = this.header.y + this.header.height + 20;
			for (text in Main.warningText)
			{
				
				var body : TextField = new TextField();
				body.autoSize = (TextFieldAutoSize.CENTER);
				body.htmlText = ('<font size="20" color="#F0F0F0">'+text+'</font>');
				body.x =  Std.int((this.stage.stageWidth - body.width)/2);
				body.y =  yPosition;
				this.warningTextField.push(body);
				this.addChild(body);
				yPosition += body.height;
			}
		}
	}

	private inline function clearMain()
	{
		this.removeChild(this.buttonEnter);
		this.buttonEnter = null;
		this.removeChild(this.header);
		this.header = null;
		this.removeChild(this.message);
		this.message = null;
		for (field in this.warningTextField)
		{
			this.removeChild(field);
		}
		this.warningTextField = null;
	}

	private inline function createButton(buttonText : String) : SimpleButton
	{
		var text : String = ('<font size="32">' + buttonText + "</font>");
		var buttonUp: TextField = new TextField();
		buttonUp.autoSize = (TextFieldAutoSize.LEFT);
		buttonUp.htmlText = text;
		buttonUp.border = true;
		buttonUp.background = true;
		buttonUp.backgroundColor = 0xD0D0D0;

		var buttonOver: TextField = new TextField();
		buttonOver.autoSize = (TextFieldAutoSize.LEFT);
		buttonOver.htmlText = text;
		buttonOver.background = true;
		buttonOver.backgroundColor = 0xE0E0E0;
		buttonOver.border = true;

		var buttonDown: TextField = new TextField();
		buttonDown.autoSize = (TextFieldAutoSize.LEFT);
		buttonDown.htmlText = text;
		buttonDown.background = true;
		buttonDown.backgroundColor = 0x505050;
		buttonDown.border = true;

		var buttonHit: TextField = new TextField();
		buttonHit.autoSize = (TextFieldAutoSize.LEFT);
		buttonHit.htmlText = text;
		buttonHit.background = true;
		buttonHit.backgroundColor = 0xF0F0F0;
		buttonHit.border = true;

		return (new SimpleButton(buttonUp,buttonOver,buttonDown,buttonHit));
	}

	private inline function placeTiles()
	{ 
		this.stage.color = 0x7e868f;
		this.graphics.beginFill();
		this.graphics.beginBitmapFill(Assets.getBitmapData ("assets/ajbm.png"));
		this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
		this.graphics.endFill();

		bookOpen = new Sprite();
		bookOpen.addChild(new Bitmap (Assets.getBitmapData ("assets/ajmb2.png")));
		bookOpen.x = (this.stage.stageWidth - bookOpen.width) / 2;
		bookOpen.y = (this.stage.stageHeight - bookOpen.height) / 2;
		bookOpen.buttonMode = true;
		// do not add this child.
		bookOpen.addEventListener(MouseEvent.CLICK, bookOpen_onMouseClick);

		bookClosed = new Sprite();
		bookClosed.addChild(new Bitmap (Assets.getBitmapData ("assets/ajmb1.png")));
		bookClosed.x = this.stage.stageWidth - bookClosed.width - 10;
		bookClosed.y = this.stage.stageHeight - bookClosed.height - 10;
		bookClosed.buttonMode = true;
		this.addChild (bookClosed);
		bookClosed.addEventListener(MouseEvent.CLICK, bookClosed_onMouseClick);

		
		for (i in 1...8)
		{
			for (j in 0...2)
			{
				tile = new AJTile(i, (Math.random() >= 0.50));
				tile.x = 50 + (i+j)*60;
				tile.y = this.stage.stageHeight - tile.height + 20;
				tile.buttonMode = true;
				this.addChild (tile);
				tile.addEventListener (MouseEvent.MOUSE_DOWN, tile_onMouseDown);
				tile.addEventListener (MouseEvent.MOUSE_WHEEL, tile_onMouseAlt);
				tile.addEventListener (MouseEvent.RIGHT_CLICK, tile_onMouseAlt);
			}
		}

		
	
		
	}	
	
	
	
	private function buttonEnter_onMouseClick (event:MouseEvent):Void
	{
		this.clearMain();
		this.placeTiles();
	}

	private function bookOpen_onMouseClick(event:MouseEvent):Void
	{
		this.removeChild(bookOpen);
	}
	
	private function bookClosed_onMouseClick(event:MouseEvent):Void
	{
		this.addChild(bookOpen);
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
			var xPosition : Float =  tileWidth * Math.round(tile.x/tileWidth);
			var yPosition : Float =  tileHeight * Math.round(tile.y/tileHeight);

			if ((xPosition >= 0) && (xPosition < this.stage.stageWidth) && (yPosition >=0) && (yPosition < this.stage.stageHeight))
				Actuate.tween (tile, 1, { x: xPosition, y: yPosition } );
			else
				Actuate.tween (tile, 1, { x: 0, y: 0 } );
		}
		
		stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
	}
	
	
}
