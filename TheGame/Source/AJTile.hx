/**
* Part of Source for The Game.
* Developed by @Tggtt for the community at https://recess.fandom.com
* Licensed as CC-by-SA-4.0.
*/

package;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;

class AJTile extends Sprite
{
	private var rotated : Bool;
	private var bitmapNormal : Bitmap;
	private var bitmapRotated : Bitmap;
	public function new(tileNum : Int, _rotated : Bool = true)
	{
		super();
		this.bitmapNormal = (new Bitmap (Assets.getBitmapData ("assets/aj"+ Std.string(tileNum) +".png")));
		this.bitmapRotated = (new Bitmap (Assets.getBitmapData ("assets/aj"+ Std.string(tileNum) +"r.png")));
		this.setRotated(_rotated);
		this.updateRotated();
	}

	public function setRotated(_rotated : Bool = true)
	{
		this.rotated = _rotated;
	}

	public inline function invertRotated()
	{
		this.setRotated(! this.rotated);
	}

	public inline function isRotated()
	{
		return (this.rotated);
	}

	public inline function updateRotated()
	{
		if (this.rotated)
		{
			this.addChild(bitmapRotated);
			this.removeChild(bitmapNormal);
		}
		else
		{
			this.addChild(bitmapNormal);
			this.removeChild(bitmapRotated);
		}
	}
}
