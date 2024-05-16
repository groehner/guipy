unit UImages;

interface

uses
   Classes, Controls, ImgList, System.ImageList;

type
  TDMImages = class(TDataModule)
    ILBookmarksLight: TImageList;
    ILUMLRtfdComponentsLight: TImageList;
    ILInteractive: TImageList;
    ILInteractiveDark: TImageList;
    ILUMLRtfdComponentsDark: TImageList;
    ILBookmarksDark: TImageList;
    ILPythonControls: TImageList;
    ILUMLToolbarLight: TImageList;
    ILUMLToolbarDark: TImageList;
    ILQtControls: TImageList;
    ILEditorToolbar: TImageList;
    ILEditorToolbarDark: TImageList;
    ILStructogramToolbar: TImageList;
    ILStructogramToolbarDark: TImageList;
    ILSequenceToolbar: TImageList;
    ILSequenceToolbarDark: TImageList;
    ILTextDiffLight: TImageList;
    ILTextDiffDark: TImageList;
    ILBrowser: TImageList;
    ILContextMenuLight: TImageList;
    ILContextMenuDark: TImageList;
    ILSequencediagramLight: TImageList;
    ILSequencediagramDark: TImageList;
    ILStructogramDark: TImageList;
    ILStructogramLight: TImageList;
    ILGUIDesigner: TImageList;
    ILAssociationsLight: TImageList;
    ILAssociationsDark: TImageList;
    ILUMLLight: TImageList;
    ILUMLDark: TImageList;
    ILAssoziationenLight: TImageList;
    ILAssoziationenDark: TImageList;
    ILAlign: TImageList;
    ILClassEditor: TImageList;
    ILSequenceConnectLight: TImageList;
    ILSequenceConnectDark: TImageList;
  public
    procedure AdjustImageListsToDPI(OldDPI, NewDPI: integer);
  end;

var
  DMImages: TDMImages;

implementation

uses frmPyIDEMain;

{$R *.dfm}

procedure TDMImages.AdjustImageListsToDPI(OldDPI, NewDPI: integer);
begin
  for var i := 0 to ComponentCount - 1 do
    if Components[i] is TImageList then
      PyIDEMainForm.ResizeImageListImagesforHighDPI(TImageList(Components[i]), OldDPI, NewDPI);
end;

end.
