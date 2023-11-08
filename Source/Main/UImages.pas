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
  end;

var
  DMImages: TDMImages;

implementation

{$R *.dfm}

end.
