unit UImages;

interface

uses
  Classes,
  Vcl.BaseImageCollection,
  SVGIconImageCollection;

type
  TDMImages = class(TDataModule)
    icSequencediagram: TSVGIconImageCollection;
    icEditorBookmarks: TSVGIconImageCollection;
    icEditorToolbar: TSVGIconImageCollection;
    icEditorContextMenu: TSVGIconImageCollection;
    icTkInter: TSVGIconImageCollection;
    icTTKinter: TSVGIconImageCollection;
    icQtBase: TSVGIconImageCollection;
    icQtControls: TSVGIconImageCollection;
    icProgram: TSVGIconImageCollection;
  end;

var
  DMImages: TDMImages;

implementation

{$R *.dfm}

end.
