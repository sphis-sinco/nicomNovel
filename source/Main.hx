import macohi.util.ControlClass;
import macohi.debugging.CrashHandler;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var controls:ControlClass = new ControlClass();
	
	public function new()
	{
		super();

		CrashHandler.initalize(null, 'nicomNovel_', null, 'nicomNovel');

		controls.keybinds.set('left', ['A', 'LEFT']);
		controls.keybinds.set('down', ['S', 'DOWN']);
		controls.keybinds.set('up', ['W', 'UP']);
		controls.keybinds.set('right', ['D', 'RIGHT']);
		controls.keybinds.set('accept', ['ENTER']);
		controls.keybinds.set('back', ['BACKSPACE', 'ESCAPE']);
		
		addChild(new FlxGame(0, 0, InitState));
	}
}
