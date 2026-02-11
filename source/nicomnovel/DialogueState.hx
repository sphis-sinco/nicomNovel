package nicomnovel;

import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import flixel.util.FlxSignal.FlxTypedSignal;
import macohi.overrides.MText;
import macohi.funkin.koya.backend.AssetPaths;
import macohi.util.WindowUtil;
import macohi.util.StringUtil;
import flixel.FlxG;
import macohi.overrides.MSprite;
import macohi.overrides.MState;

class DialogueState extends MState
{
	public var dialogue:Array<String> = [];
	public var dialoguePath:String = '';

	public var dialogueBox:MSprite;

	public var dialogueText:MText;
	public var dialogueTextPadding:Float = 10.0;

	public var dialogueIndex:Int = 0;

	public var onDialogueEnd:FlxSignal = new FlxSignal();
	public var onDialogueContinue:FlxSignal = new FlxSignal();

	public var canProceed:Bool = false;

	override function create()
	{
		super.create();

		initalizeDialogueBox();
		initalizeDialogueText();

		displayDialogue();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Main.controls.justReleased('accept') && canProceed)
			continueDialogue();
	}

	public function initalizeDialogueBox()
	{
		var fuckyou = 0.4;

		dialogueBox = new MSprite().makeGraphic(Math.round(FlxG.width * 0.8), Math.round(FlxG.height * fuckyou));

		dialogueBox.screenCenter();
		dialogueBox.y = Math.round(FlxG.height - dialogueBox.height * 1.2);

		add(dialogueBox);
	}

	public function initalizeDialogueText()
	{
		if (dialogueBox == null)
		{
			WindowUtil.alert('DialogueState : initalizeDialogueText',
				'dialogueText cannot be initalized without the dialogueBox,\nplease override the state if this is intentional\nto remove this check');

			return;
		}

		dialogueText = new MText(0, 0, dialogueBox.width, 'Lorem', 32);

		dialogueText.color = FlxColor.BLACK;
		dialogueText.alignment = LEFT;

		add(dialogueText);
	}

	public function loadDialogueFile(filename:String)
	{
		var filepath:String = AssetPaths.txt('data/$filename');

		dialogue = StringUtil.splitTextAssetByNewlines(filepath);

		if (dialogue == null)
			dialogue = [];

		if (dialogue.length == 0)
			WindowUtil.alert('DialogueState : loadDialogueFile', 'Dialogue file : $filepath\nhad an error being loaded and there\'s no dialogue.');

		dialoguePath = filepath;
	}

	public function continueDialogue()
	{
		dialogueIndex++;

		if (dialogueIndex > dialogue.length - 1)
		{
			dialogueIndex = dialogue.length - 1;
			endDialogue();

			return;
		}

		displayDialogue();

		if (onDialogueContinue != null)
			onDialogueContinue.dispatch();
	}

	public function displayDialogue()
	{
		dialogueText.setPosition(dialogueBox.x + dialogueTextPadding, dialogueBox.y + dialogueTextPadding);

		dialogueText.text = dialogue[dialogueIndex];
		canProceed = true;
	}

	public function endDialogue()
	{
		if (onDialogueEnd != null)
			onDialogueEnd.dispatch();
	}
}
