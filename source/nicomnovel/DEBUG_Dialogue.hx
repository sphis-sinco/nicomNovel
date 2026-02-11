package nicomnovel;

class DEBUG_Dialogue extends DialogueState
{
	override public function new()
	{
		super();

		loadDialogueFile('debug');
	}
}
