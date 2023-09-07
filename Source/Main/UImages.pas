unit UImages;

interface

uses
   Classes, Controls, ImgList, System.ImageList;

type
  TDMImages = class(TDataModule)
    ILBookmarksLight: TImageList;
    ILUMLRtfdComponentsLight: TImageList;
    ILSwing1: TImageList;
    ILInteractive: TImageList;
    ILProgram: TImageList;
    ILProgramDark: TImageList;
    ILSwing1Dark: TImageList;
    ILInteractiveDark: TImageList;
    ILUMLRtfdComponentsDark: TImageList;
    ILBookmarksDark: TImageList;
    ILPythonControls: TImageList;
    ILUMLToolbarLight: TImageList;
    ILUMLToolbarDark: TImageList;
    ILQtControls: TImageList;
  end;

var
  DMImages: TDMImages;

implementation

{$R *.dfm}

end.
