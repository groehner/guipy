{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: dlgConfirmReplace.dpr, released 2000-06-23.

The Original Code is part of the SearchReplaceDemo project, written by
Michael Hieke for the SynEdit component suite.
All Rights Reserved.

Contributors to the SynEdit project are listed in the Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.
-------------------------------------------------------------------------------}

unit dlgConfirmReplace;

{$I SynEdit.inc}

interface

uses
  Winapi.Windows,
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  dlgPyIDEBase;

type
  TConfirmReplaceDialog = class(TPyIDEDlgBase)
    Image1: TImage;
    Panel1: TPanel;
    lblConfirmation: TLabel;
    btnReplace: TButton;
    btnSkip: TButton;
    btnCancel: TButton;
    btnReplaceAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  public
    procedure PrepareShow(AEditorRect: TRect; X, Y1, Y2: Integer;
      AReplaceText: string);
  end;

var
  ConfirmReplaceDialog: TConfirmReplaceDialog;

implementation

uses
  System.SysUtils;

{$R *.DFM}

resourcestring
  SAskReplaceText = 'Replace this occurrence of "%s"?';

{ TConfirmReplaceDialog }

procedure TConfirmReplaceDialog.FormCreate(Sender: TObject);
begin
  inherited;
  Image1.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
end;

procedure TConfirmReplaceDialog.FormDestroy(Sender: TObject);
begin
  ConfirmReplaceDialog := nil;
end;

procedure TConfirmReplaceDialog.PrepareShow(AEditorRect: TRect;
  X, Y1, Y2: Integer; AReplaceText: string);
var
  RectWidth, RectHeight: Integer;
begin
  lblConfirmation.Caption := Format(SAskReplaceText, [AReplaceText]);
  RectWidth := AEditorRect.Width;
  RectHeight := AEditorRect.Height;

  if RectWidth <= Width then
    X := AEditorRect.Left - (Width - RectWidth) div 2
  else begin
    if X + Width > AEditorRect.Right then
      X := AEditorRect.Right - Width;
  end;
  if Y2 > AEditorRect.Top + MulDiv(RectHeight, 2, 3) then
    Y2 := Y1 - Height - 4
  else
    Inc(Y2, 4);
  SetBounds(X, Y2, Width, Height);
end;

end.

