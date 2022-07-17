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
import openfl.utils.Assets;

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
		hitbox.add(buttonLeft = createHint(0, 0, 'left', 0xFFFF00FF));
		hitbox.add(buttonDown = createHint(FlxG.width / 4, 0, 'down', 0xFF00FFFF));
		hitbox.add(buttonUp = createHint(FlxG.width / 2, 0, 'up', 0xFF00FF00));
		hitbox.add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, 'right', 0xFFFF0000));
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

	private function createHint(X:Float, Y:Float, Graphic:String, ?Color:Int = 0xFFFFFF):FlxButton
	{
		var hintTween:FlxTween;
		var hint:FlxButton = new FlxButton(X, Y);
		hint.loadGraphic(FlxGraphic.fromFrame(FlxAtlasFrames.fromSparrow(Assetd.getBitmapData('assets/android/hitbox.png'), Assetd.getText('assets/android/hitbox.xml')).getByName(Graphic)));
		hint.setGraphicSize(Std.int(FlxG.width / 4), FlxG.height);
		hint.updateHitbox();
		hint.color = Color;
		hint.alpha = 0.00001;
		hint.onDown.callback = function()
		{
			if (buttonTween != null)
				buttonTween.cancel();

			buttonTween = FlxTween.num(hint.alpha, 0.6, 0.06, {ease: FlxEase.circInOut}, function(value:Float)
			{
				hint.alpha = value;
			});
		}
		hint.onUp.callback = function()
		{
			if (buttonTween != null)
				buttonTween.cancel();

			buttonTween = FlxTween.num(hint.alpha, 0.00001, 0.15, {ease: FlxEase.circInOut}, function(value:Float)
			{
				hint.alpha = value;
			});
		}
		hint.onOut.callback = function()
		{
			if (buttonTween != null)
				buttonTween.cancel();

			buttonTween = FlxTween.num(hint.alpha, 0.00001, 0.2, {ease: FlxEase.circInOut}, function(value:Float)
			{
				hint.alpha = value;
			});
		}
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}
}
