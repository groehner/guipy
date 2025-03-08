unit UUMLInteractive;

interface

uses
  System.Classes,
  System.ImageList,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Vcl.BaseImageCollection,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  Vcl.Menus,
  SynEdit,
  TB2Item,
  SpTBXItem,
  JvAppStorage,
  frmFile,
  frmIDEDockWin,
  SVGIconImageCollection;

type
  TFUMLInteractive = class(TIDEDockWindow, IJvAppStorageHandler)
    TBInteractiveToolbar: TToolBar;
    TBInteractiveClose: TToolButton;
    TBExecute: TToolButton;
    TBSynEditZoomMinus: TToolButton;
    TBSynEditZoomPlus: TToolButton;
    TBDelete: TToolButton;
    vilInteractiveLight: TVirtualImageList;
    vilInteractiveDark: TVirtualImageList;
    icInteractive: TSVGIconImageCollection;
    vilPMInteractiveLight: TVirtualImageList;
    vilPMInteractiveDark: TVirtualImageList;
    icPMInteractive: TSVGIconImageCollection;
    SynEdit: TSynEdit;
    PMInteractive: TSpTBXPopupMenu;
    MIClose: TSpTBXItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    MIPaste: TSpTBXItem;
    MICopy: TSpTBXItem;
    MIDelete: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MICopyAll: TSpTBXItem;
    MIDeleteAll: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIFont: TSpTBXItem;
    procedure MICloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TBInteractiveCloseClick(Sender: TObject);
    procedure TBExecuteClick(Sender: TObject);
    procedure TBSynEditZoomMinusClick(Sender: TObject);
    procedure TBSynEditZoomPlusClick(Sender: TObject);
    procedure TBDeleteClick(Sender: TObject);
    procedure MIPasteClick(Sender: TObject);
    procedure MICopyClick(Sender: TObject);
    procedure MIDeleteClick(Sender: TObject);
    procedure MICopyAllClick(Sender: TObject);
    procedure MIDeleteAllClick(Sender: TObject);
    procedure MIFontClick(Sender: TObject);
    procedure SynEditChange(Sender: TObject);
  private
    FMyForm: TFileForm;
  protected
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    procedure Init(Lines: TStrings; Form: TFileForm);
    procedure SaveInteractiveLines;
    procedure Add(Line: string);
    procedure Clear;
    procedure ChangeStyle;
  end;

var
  FUMLInteractive: TFUMLInteractive;

implementation

{$R *.dfm}

uses
  System.Math,
  System.SysUtils,
  Vcl.Clipbrd,
  dmResources,
  JvGnugettext,
  cPyScripterSettings,
  uCommonFunctions,
  UUMLForm,
  UConfiguration;

procedure TFUMLInteractive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFUMLInteractive.FormCreate(Sender: TObject);
begin
  inherited;
  FMyForm:= nil;
  Visible:= False;
  TranslateComponent(Self);
  SynEdit.PopupMenu:= PMInteractive;
  SynEdit.Font.Name:= DefaultCodeFontName;
  ChangeStyle;
end;

procedure TFUMLInteractive.FormShow(Sender: TObject);
begin
  SetFocus;
end;

procedure TFUMLInteractive.MICloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFUMLInteractive.MICopyClick(Sender: TObject);
begin
  Clipboard.AsText:= SynEdit.SelText;
end;

procedure TFUMLInteractive.MICopyAllClick(Sender: TObject);
begin
  Clipboard.AsText:= SynEdit.Text;
end;

procedure TFUMLInteractive.MIDeleteAllClick(Sender: TObject);
begin
  SynEdit.Clear;
end;

procedure TFUMLInteractive.MIDeleteClick(Sender: TObject);
begin
  SynEdit.DeleteSelections;
end;

procedure TFUMLInteractive.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(SynEdit.Font);
  if ResourcesDataModule.dlgFontDialog.Execute then
    SynEdit.Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
end;

procedure TFUMLInteractive.MIPasteClick(Sender: TObject);
begin
  SynEdit.PasteFromClipboard;
end;

procedure TFUMLInteractive.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  var CurrentSize:= SynEdit.Font.Size;
  SynEdit.Font.Size:= PPIUnScale(SynEdit.Font.Size);
  AppStorage.WritePersistent(BasePath+'\Font', SynEdit.Font);
  SynEdit.Font.Size:= CurrentSize;
end;

procedure TFUMLInteractive.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  AppStorage.ReadPersistent(BasePath + '\Font', SynEdit.Font);
  SynEdit.Font.Size:= PPIScale(SynEdit.Font.Size);
end;

procedure TFUMLInteractive.SynEditChange(Sender: TObject);
begin
  if Assigned(FMyForm) then
    FMyForm.Modified:= True;
end;

procedure TFUMLInteractive.TBDeleteClick(Sender: TObject);
begin
  if SynEdit.SelAvail
    then SynEdit.DeleteSelections
    else SynEdit.Clear;
end;

procedure TFUMLInteractive.TBExecuteClick(Sender: TObject);
  var Text: string; TSL: TStringList;  UMLForm: TFUMLForm;
begin
  if not Assigned(FMyForm) then
   Exit;
  UMLForm:= FMyForm as TFUMLForm;
  if SynEdit.SelAvail
    then Text:= SynEdit.SelText
    else Text:= SynEdit.LineText;
  SynEdit.SelStart:= SynEdit.SelEnd;
  if Text = '' then Exit;
  Text:= StringReplace(Text, #9, StringOfChar(' ', SynEdit.TabWidth), [rfReplaceAll]);
  Text:= Dedent(Text);
  UMLForm.CollectClasses(nil);
  TBExecute.Enabled:= False;
  Screen.Cursor:= crHourGlass;
  TSL := TStringList.Create;
  try
    UMLForm.MainModul.Diagram.ExecutePython(Text);
    if GuiPyOptions.ShowAllNewObjects then
      UMLForm.MainModul.Diagram.ShowAllNewObjects(Self);
    UMLForm.MainModul.Diagram.ShowAll;
  finally
    TSL.Free;
    Screen.Cursor:= crDefault;
    TBExecute.Enabled:= True;
  end;
end;

procedure TFUMLInteractive.TBInteractiveCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFUMLInteractive.TBSynEditZoomMinusClick(Sender: TObject);
begin
  SynEdit.Font.Size:= Max(SynEdit.Font.Size -1, 6);
end;

procedure TFUMLInteractive.TBSynEditZoomPlusClick(Sender: TObject);
begin
  SynEdit.Font.Size:= SynEdit.Font.Size + 1;
end;

procedure TFUMLInteractive.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    TBInteractiveToolbar.Images:= vilInteractiveDark;
    PMInteractive.Images:= vilPMInteractiveDark;
  end else begin
    TBInteractiveToolbar.Images:= vilInteractiveLight;
    PMInteractive.Images:= vilPMInteractiveLight;
  end;
  SynEdit.Highlighter:= ResourcesDataModule.Highlighters.HighlighterFromFileExt('py');
end;

procedure TFUMLInteractive.Init(Lines: TStrings; Form: TFileForm);
begin
  FMyForm:= Form;
  SynEdit.Text:= Lines.Text;
end;

procedure TFUMLInteractive.SaveInteractiveLines;
begin
  if Assigned(FMyForm) then begin
    (FMyForm as TFUMLForm).InteractiveLines:= SynEdit.Lines;
    SynEdit.Clear;
  end;
end;

procedure TFUMLInteractive.Clear;
begin
  SynEdit.Clear;
  FMyForm:= nil;
end;

procedure TFUMLInteractive.Add(Line: string);
begin
  SynEdit.Lines.Add(Line);
  var LineNo:= SynEdit.Lines.Count - 1;
  if LineNo < 1 then LineNo:= 1;
  SynEdit.TopLine:= LineNo;
end;

end.