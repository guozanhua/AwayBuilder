package awaybuilder.controller.history
{
    import awaybuilder.model.UndoRedoModel;
    
    import org.robotlegs.mvcs.Command;

    public class HistoryCommandBase extends Command
    {
        [Inject]
        public var undoRedoModel:UndoRedoModel;
		
        protected function addToHistory(event:HistoryEvent):void {
            if (!event.isUndoAction&&!event.isRedoAction)
            {
                if( event.canBeCombined )
                {
                    var lastEvent:HistoryEvent = undoRedoModel.getLastActon();
                    if( lastEvent && lastEvent.canBeCombined && lastEvent.type==event.type )
                    {
                        lastEvent.newValue = event.newValue;
                        return;
                    }
                }

                undoRedoModel.registerAction(event.clone() as HistoryEvent);
            }
        }
    }
}