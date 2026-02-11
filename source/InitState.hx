import nicomnovel.DEBUG_Dialogue;
import flixel.FlxG;
import macohi.overrides.MState;

class InitState extends MState
{
	override public function create()
	{
		super.create();

		FlxG.switchState(DEBUG_Dialogue.new);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
