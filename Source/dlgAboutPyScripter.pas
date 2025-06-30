{-----------------------------------------------------------------------------
 Unit Name: dlgAboutPyScripter
 Author:    Kiriakos Vlahos, Gerhard Röhner
 Date:      09-Mar-2005
 Purpose:   PyScripter About box
 History:
-----------------------------------------------------------------------------}

unit dlgAboutPyScripter;

interface

uses
  Winapi.Windows, Winapi.Messages, Controls,
  ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  dlgPyIDEBase, SpTBXTabs, SpTBXPageScroller, SVGIconImage,
  TB2Item, SpTBXItem, System.Classes;

type
  TRichEdit = class(Vcl.ComCtrls.TRichEdit)
  private
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure CreateWnd; override;
  end;

  TAboutBox = class(TPyIDEDlgBase)
    SpTBXTabControl: TSpTBXTabControl;
    tbAbout: TSpTBXTabItem;
    SpTBXTabSheet1: TSpTBXTabSheet;
    tbCredits: TSpTBXTabItem;
    SpTBXTabSheet2: TSpTBXTabSheet;
    tbLinks: TSpTBXTabItem;
    SpTBXTabSheet3: TSpTBXTabSheet;
    ScrollBox: TSpTBXPageScroller;
    Panel1: TPanel;
    Copyright: TLabel;
    Version: TLabel;
    ProductName: TLabel;
    Comments: TLabel;
    reLinks: TRichEdit;
    reCredits: TRichEdit;
    Panel2: TPanel;
    SVGIconImage1: TSVGIconImage;
    procedure Panel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure reCreditsResizeRequest(Sender: TObject; Rect: TRect);
  end;

var
  AboutBox: TAboutBox;

implementation

uses
  Winapi.ShellAPI, Winapi.RichEdit, uCommonFunctions, JvGnugettext,
  SysUtils, Graphics, Forms, UUpdate;

{$R *.dfm}

const
  SAboutBoxCredits =
    'PyScripter (www.github.com/pyscripter/pyscripter)' + sLineBreak +
    'Java-Editor (www.javaeditor.org)' + sLineBreak +
    'ESS-Model (http://essmodel.sourceforge.net)' + sLineBreak +
    'Extension Library (https://torry.net/authorsmore.php?id=3588)' + sLineBreak +
    'TextDiff (http://www.angusj.com/delphi/textdiff.html)' + sLineBreak +
    'Python for Delphi (www.github.com/pyscripter/python4delphi)'+ sLineBreak +
    'Rpyc (www.github.com/tomerfiliba/rpyc)'+ sLineBreak +
    'JVCL (www.github.com/project-jedi/jvcl)'+ sLineBreak +
    'SynEdit (www.sourceforge.net/projects/synedit)'+ sLineBreak +
    'VirtualTreeView (www.github.com/Virtual-TreeView/)'+ sLineBreak +
    'VirtualShellTools (www.github.com/pyscripter/mustangpeakvirtualshelltools)'+ sLineBreak +
    'GExperts (www.gexperts.org)'+ sLineBreak +
    'Syn Editor (www.sourceforge.net/projects/syn)'+ sLineBreak +
    'Syn Web highlighters (www.github.com/KrystianBigaj/synweb)' + sLineBreak +
    'Toolbar2000 (www.jrsoftware.org/tb2k.php)'+ sLineBreak +
    'SpTBXLib (www.silverpointdevelopment.com)' + sLineBreak +
    'SVGIconImageList (https://github.com/EtheaDev/SVGIconImageList)' + sLineBreak +
    'zControls/Detours library (https://github.com/MahdiSafsafi)' + sLineBreak +
    'TCommandLineReader (www.benibela.de)';

  SComments =
   'A free and open source Python IDE created to support' + sLineBreak +
   'learning and teaching informatics with various modeling techniques.' + sLineBreak +
   sLineBreak +
   'GuiPy is based on PyScripter and extends it with a lot of graphical tools:' + sLineBreak +
   '- Class designer for modeling classes' + sLineBreak +
   '- UML window with class diagrams and interactive object creation' + sLineBreak +
   '- sequence diagram editor' + sLineBreak +
   '- structogram editor' + sLineBreak +
   '- GUI designer for easy creation of Tkinter, TTK or Qt apps' + sLineBreak +
   '- diff text tool';

resourcestring
  SAboutBoxCreditsIntro =
    'Special thanks to the many great developers who,'+
    'with their amazing work, have made GuiPy '+
    'possible. GuiPy makes use of the following '+
    'components and projects:';

  SAboutBoxCreditsTranslationArabic  = 'Arabic: %s';
  SAboutBoxCreditsTranslationChinese = 'Chinese: %s';
  SAboutBoxCreditsTranslationFrench  = 'French: %s';
  SAboutBoxCreditsTranslationGerman  = 'German: %s';
  SAboutBoxCreditsTranslationGreek   = 'Greek: %s';
  SAboutBoxCreditsTranslationItalian = 'Italian: %s';
  SAboutBoxCreditsTranslationJapanese = 'Japanese: %s';
  SAboutBoxCreditsTranslationKabyle = 'Taqbaylit: %s';
  SAboutBoxCreditsTranslationPortugueseBR = 'Portuguese (Brazil): %s';
  SAboutBoxCreditsTranslationPortuguesePT = 'Portuguese (Portugal): %s';
  SAboutBoxCreditsTranslationRussian = 'Russian: %s';
  SAboutBoxCreditsTranslationSlovak  = 'Slovak: %s';
  SAboutBoxCreditsTranslationSpanish = 'Spanish: %s';
  SAboutBoxCreditsTranslationTurkish = 'Turkish: %s';

  SAboutBoxLinks =
    'The project home, Issue Tracker and source code repository are hosted at Github (www.github.com/groehner/GuiPy)'+
    sLineBreak +
    'Please submit bug reports and questions about GuiPy to groehner@t-online.de';

const
  AURL_ENABLEURL = 1;
  AURL_ENABLEEAURLS = 8;

type
  // in alphabetical order of the full English languages names!!
  // not in order of the gettext abbreviations.
  TCreditLanguages = (ar,zh,fr,de,el,it,ja,kab,pt_BR,pt_PT,ru,sk,es,tr);

const
  CAboutLanguages : array[TCreditLanguages] of string = (
    SAboutBoxCreditsTranslationArabic,
    SAboutBoxCreditsTranslationChinese,
    SAboutBoxCreditsTranslationFrench,
    SAboutBoxCreditsTranslationGerman,
    SAboutBoxCreditsTranslationGreek,
    SAboutBoxCreditsTranslationItalian,
    SAboutBoxCreditsTranslationJapanese,
    SAboutBoxCreditsTranslationKabyle,
    SAboutBoxCreditsTranslationPortugueseBR,
    SAboutBoxCreditsTranslationPortuguesePT,
    SAboutBoxCreditsTranslationRussian,
    SAboutBoxCreditsTranslationSlovak,
    SAboutBoxCreditsTranslationSpanish,
    SAboutBoxCreditsTranslationTurkish
  );
  CAboutTranslationManager = 'Lübbe Onken';
  CAboutTranslators : array[TCreditLanguages] of string = (
    'Mohammed Nasman, Raouf Rahiche',
    '"Love China"',
    'Groupe AmiensPython, Vincent Maille, Phil Prost',
    'Daniel Frost, Lübbe Onken',
    'Kiriakos Vlahos',
    'Vincenzo Campanella, bovirus (bovirus@gmail.com)',
    'Tokibito',
    'Mohammed Belkacem',
    'Eric Szczepanik',
    'Gustavo Carreno',
    'Aleksander Dragunkin, Andrei Aleksandrov, Dmitry Arefiev',
    'Marian Denes',
    'Pedro Luis Larrosa, Victor Alberto Gil, Juan Carlos Cilleruelo',
    'Gökhan Cengiz'
  );

  CAboutBoxCreditsThemeDesign =
    'Adriana Díaz - Aumenta Software (https://aumenta.mx/)' + sLineBreak +
    'Salim Saddaquzzaman (https://github.com/sk-Prime)'+ sLineBreak +
    'Tanmaya Meher (www.github.com/tanmayameher)'+ sLineBreak +
    'jprzywoski (www.github.com/jprzywoski)';

procedure TRichEdit.CreateWnd;
var
  Mask: LResult;
begin
  inherited;
  Mask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0);
  SendMessage(Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
  SendMessage(Handle, EM_AUTOURLDETECT, AURL_ENABLEURL, 0);
end;

procedure TRichEdit.CNNotify(var Message: TWMNotify);
type
  PENLink = ^TENLink;
var
  PenLnk: PENLink;
  TR: TEXTRANGE;
  Url: array of Char;
begin
  if (Message.NMHdr.code = EN_LINK) then begin
    PenLnk := PENLink(Message.NMHdr);
    if (PenLnk.Msg = WM_LBUTTONDOWN) then begin
      { optionally, enable this:
      if CheckWin32Version(6, 2) then begin
        // on Windows 8+, returning EN_LINK_DO_DEFAULT directs
        // the RichEdit to perform the default action...
        Message.Result :=  EN_LINK_DO_DEFAULT;
        Exit;
      end;
      }
      try
        SetLength(url, PenLnk.chrg.cpMax - PenLnk.chrg.cpMin + 1);
        TR.chrg := PenLnk.chrg;
        TR.lpstrText := PChar(url);
        SendMessage(Handle, EM_GETTEXTRANGE, 0, LPARAM(@tr));
        ShellExecute(Handle, nil, PChar(url), nil, nil, SW_SHOWNORMAL);
      except
        {ignore}
      end;
      Exit;
    end;
  end;
  inherited;
end;

procedure TAboutBox.Panel1Click(Sender: TObject);
begin
  Close;
end;

procedure TAboutBox.reCreditsResizeRequest(Sender: TObject; Rect: TRect);
begin
  reCredits.BoundsRect := Rect;
end;

procedure TAboutBox.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
var
  AboutBoxCreditsTranslations : string;
  Language : TCreditLanguages;
begin
  inherited;
  Copyright.Caption := #$00A9' Gerhard Röhner 2021-' + CurrentYear.ToString;
  Version.Caption:= 'Version ' + UUpdate.Version + sLineBreak + TFUpdate.GetVersionDate;
  Comments.Caption:= sComments;

  AddFormatText(reLinks, _('Links') + sLineBreak, [fsBold]);
  reLinks.Paragraph.Numbering := nsBullet;
  AddFormatText(reLinks,SAboutBoxLinks);
  reLinks.ReadOnly := True;

  AddFormatText(reCredits, _('Credits') + sLineBreak, [fsBold]);
  AddFormatText(reCredits,SAboutBoxCreditsIntro + sLineBreak);
  reCredits.Paragraph.Numbering := nsBullet;
  AddFormatText(reCredits,SAboutBoxCredits + sLineBreak);

  reCredits.Paragraph.Numbering := nsNone;
  AddFormatText(reCredits, sLineBreak + _('Translation manager') + ':' + sLineBreak, [fsItalic]);
  reCredits.Paragraph.Numbering := nsBullet;
  AddFormatText(reCredits,cAboutTranslationManager + sLineBreak);

  reCredits.Paragraph.Numbering := nsNone;
  AddFormatText(reCredits, sLineBreak + _('Translators') + ':' + sLineBreak, [fsItalic]);

  for Language := Low(TCreditLanguages) to High(TCreditLanguages) do
    AboutBoxCreditsTranslations := AboutBoxCreditsTranslations +
      Format(cAboutLanguages[Language],[cAboutTranslators[Language]]) + sLineBreak;
  reCredits.Paragraph.Numbering := nsBullet;
  AddFormatText(reCredits,AboutBoxCreditsTranslations);

  reCredits.Paragraph.Numbering := nsNone;
  AddFormatText(reCredits, sLineBreak + _('Artwork and theme design') + ':' + sLineBreak, [fsItalic]);
  reCredits.Paragraph.Numbering := nsBullet;
  AddFormatText(reCredits, cAboutBoxCreditsThemeDesign + sLineBreak);
  reCredits.Paragraph.Numbering := nsNone;
  reCredits.SelStart := 0;
  reCredits.SelLength := 0;
  reCredits.ReadOnly := True;
end;

initialization
  TP_GlobalIgnoreClassProperty(TAboutBox, 'Copyright');
  TP_GlobalIgnoreClassProperty(TAboutBox, 'Version');
  TP_GlobalIgnoreClassProperty(TAboutBox, 'ProductName');
end.

