package android.flixel;

import android.flixel.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxDestroyUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxSpriteGroup;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;

/**
 * A hitbox.
 * It's easy to customize the layout.
 *
 * @author: Saw (M.A. Jigsaw)
 */
class FlxHitbox extends FlxSpriteGroup
{
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);

	/**
	 * Group of the hint buttons.
	 */
	public var hitbox:FlxSpriteGroup;

	/**
	 * Create a hitbox.
	 */
	public function new()
	{
		super();

		scrollFactor.set();

		hitbox = new FlxSpriteGroup();
		hitbox.add(add(buttonLeft = createHitbox(0, 0, 'left', 0xFFFF00FF)));
		hitbox.add(add(buttonDown = createHitbox(FlxG.width / 4, 0, 'down', 0xFF00FFFF)));
		hitbox.add(add(buttonUp = createHitbox(FlxG.width / 2, 0, 'up', 0xFF00FF00)));
		hitbox.add(add(buttonRight = createHitbox((FlxG.width / 2) + (FlxG.width / 4), 0, 'right', 0xFFFF0000)));
		hitbox.scrollFactor.set();
	}

	override function destroy()
	{
		super.destroy();

		hitbox = FlxDestroyUtil.destroy(hitbox);
		hitbox = null;
		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}

	private function createHitbox(X:Float, Y:Float, Graphic:String, ?Color:Int = 0xFFFFFF):FlxButton
	{
		var buttonTween:FlxTween;
		var button:FlxButton = new FlxButton(X, Y);
		button.loadGraphic(FlxGraphic.fromFrame(FlxAtlasFrames.fromSparrow('assets/android/hitbox.png', 'assets/android/hitbox.xml').getByName(Graphic)));
		button.setGraphicSize(Std.int(FlxG.width / 4), FlxG.height);
		button.updateHitbox();
		button.color = Color;
		button.alpha = 0.00001;
		button.onDown.callback = function()
		{
			if (buttonTween != null)
				buttonTween.cancel();

			buttonTween = FlxTween.num(button.alpha, 0.6, 0.06, {ease: FlxEase.circInOut}, function(value:Float)
			{
				button.alpha = value;
			});
		}
		button.onUp.callback = function()
		{
			if (buttonTween != null)
				buttonTween.cancel();

			buttonTween = FlxTween.num(button.alpha, 0.00001, 0.15, {ease: FlxEase.circInOut}, function(value:Float)
			{
				button.alpha = value;
			});
		}
		button.onOut.callback = function()
		{
			if (buttonTween != null)
				buttonTween.cancel();

			buttonTween = FlxTween.num(button.alpha, 0.00001, 0.2, {ease: FlxEase.circInOut}, function(value:Float)
			{
				button.alpha = value;
			});
		}
		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end
		return button;
	}
}
