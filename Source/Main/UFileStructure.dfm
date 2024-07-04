object FFileStructure: TFFileStructure
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Structure'
  ClientHeight = 477
  ClientWidth = 336
  Color = clBtnFace
  UseDockManager = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object vilFileStructure: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 336
    Height = 477
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.MainColumn = -1
    Images = vilFileStructureLight
    TabOrder = 0
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
    OnClick = vilFileStructureClick
    OnFreeNode = vilFileStructureFreeNode
    OnGetText = vilFileStructureGetText
    OnGetImageIndex = vilFileStructureGetImageIndex
    OnKeyPress = vilFileStructureKeyPress
    OnMouseDown = vilFileStructureMouseDown
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <>
  end
  object PMFileStructure: TSpTBXPopupMenu
    Images = vilFileStructureLight
    Left = 64
    Top = 24
    object MIDefaultLayout: TSpTBXItem
      Caption = 'Default layout'
      ImageIndex = 14
      ImageName = 'DefaultLayout1'
      OnClick = MIDefaulLayoutClick
    end
    object MIFont: TSpTBXItem
      Caption = 'Font'
      ImageIndex = 13
      ImageName = 'Font1'
      OnClick = MIFontClick
    end
    object MIClose: TSpTBXItem
      Caption = 'Close'
      ImageIndex = 12
      ImageName = 'Close1'
      OnClick = MICloseClick
    end
  end
  object icFileStructure: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'EditClass'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#10'<path stroke="#e1e1e1e1" d="M2 1h11' +
          'M1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h' +
          '1M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M1' +
          '3 11h1M1 12h1M13 12h1M2 13h12" />'#10'<path stroke="#8eb3dd" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#10'<path stroke="#408acc" d="M3 3h10M3 4h2M11 4h2M3 5h2M8 5h' +
          '1M12 5h1M3 6h1M7 6h3M12 6h1M3 7h1M6 7h7M3 8h1M6 8h7M3 9h1M7 9h3M' +
          '12 9h1M3 10h2M8 10h1M12 10h1M3 11h2M11 11h2M3 12h10" />'#10'<path st' +
          'roke="#468dcd" d="M5 4h1M5 11h1" />'#10'<path stroke="#a0c5e6" d="M6' +
          ' 4h1" />'#10'<path stroke="#f2f7fb" d="M7 4h2" />'#10'<path stroke="#cde' +
          '1f1" d="M9 4h1M9 11h1" />'#10'<path stroke="#5497d1" d="M10 4h1M10 1' +
          '1h1" />'#10'<path stroke="#c1d9ee" d="M5 5h1M5 10h1" />'#10'<path stroke' +
          '="#b2d0ea" d="M6 5h1M6 10h1" />'#10'<path stroke="#488fce" d="M7 5h1' +
          'M7 10h1" />'#10'<path stroke="#73aada" d="M9 5h1" />'#10'<path stroke="#' +
          'e8f0f8" d="M10 5h1M10 10h1" />'#10'<path stroke="#438bcc" d="M11 5h1' +
          '" />'#10'<path stroke="#609ed4" d="M4 6h1" />'#10'<path stroke="#f8fafc"' +
          ' d="M5 6h1M5 9h1M7 11h2" />'#10'<path stroke="#4990ce" d="M6 6h1M6 9' +
          'h1M11 10h1" />'#10'<path stroke="#70a8da" d="M10 6h1" />'#10'<path strok' +
          'e="#5094d0" d="M11 6h1" />'#10'<path stroke="#7eb1dd" d="M4 7h1" />'#10 +
          '<path stroke="#d0e3f2" d="M5 7h1M5 8h1" />'#10'<path stroke="#77acdb' +
          '" d="M4 8h1" />'#10'<path stroke="#5d9cd4" d="M4 9h1" />'#10'<path strok' +
          'e="#94bee3" d="M10 9h1" />'#10'<path stroke="#6da6d8" d="M11 9h1M9 1' +
          '0h1" />'#10'<path stroke="#aacbe9" d="M6 11h1" />'#10'</svg>'
      end
      item
        IconName = 'PrivateAttribute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ca3636" d="M3 3h9M3' +
          ' 4h1M3 5h1M3 6h1M3 7h1M3 8h1M3 9h1M3 10h1M3 11h1M3 12h1" />'#13#10'<pa' +
          'th stroke="#973636" d="M12 3h1M12 4h1M12 5h1M12 6h1M12 7h1M12 8h' +
          '1M12 9h1M12 10h1M12 11h1M4 12h9" />'#13#10'<path stroke="#fe6536" d="M' +
          '4 4h8M4 5h8M4 6h8M4 7h1M11 7h1M4 8h1M11 8h1M4 9h8M4 10h8M4 11h8"' +
          ' />'#13#10'<path stroke="#ffffff" d="M5 7h6M5 8h6" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ProtectedAttribute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ca3636" d="M3 3h9M3' +
          ' 4h1M3 5h1M3 6h1M3 7h1M3 8h1M3 9h1M3 10h1M3 11h1M3 12h1" />'#13#10'<pa' +
          'th stroke="#973636" d="M12 3h1M12 4h1M12 5h1M12 6h1M12 7h1M12 8h' +
          '1M12 9h1M12 10h1M12 11h1M4 12h9" />'#13#10'<path stroke="#fe6536" d="M' +
          '4 4h8M4 5h2M7 5h2M10 5h2M4 6h1M11 6h1M4 7h2M7 7h2M10 7h2M4 8h2M7' +
          ' 8h2M10 8h2M4 9h1M11 9h1M4 10h2M7 10h2M10 10h2M4 11h8" />'#13#10'<path' +
          ' stroke="#ffffff" d="M6 5h1M9 5h1M5 6h6M6 7h1M9 7h1M6 8h1M9 8h1M' +
          '5 9h6M6 10h1M9 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PublicAttribute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ca3636" d="M3 3h9M3' +
          ' 4h1M3 5h1M3 6h1M3 7h1M3 8h1M3 9h1M3 10h1M3 11h1M3 12h1" />'#13#10'<pa' +
          'th stroke="#973636" d="M12 3h1M12 4h1M12 5h1M12 6h1M12 7h1M12 8h' +
          '1M12 9h1M12 10h1M12 11h1M4 12h9" />'#13#10'<path stroke="#fe6536" d="M' +
          '4 4h8M4 5h3M9 5h3M4 6h3M9 6h3M4 7h1M11 7h1M4 8h1M11 8h1M4 9h3M9 ' +
          '9h3M4 10h3M9 10h3M4 11h8" />'#13#10'<path stroke="#ffffff" d="M7 5h2M7' +
          ' 6h2M5 7h6M5 8h6M7 9h2M7 10h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Class1'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'  <circle cx="8" cy="8" r="7" fill="#' +
          '3a7758"/>'#13#10'  <circle cx="8" cy="8" r="5.5" fill="#3b963a"/>'#13#10'  <' +
          'path d="M 10.5, 5 C 8.5, 3, 4.5, 4, 4.5, 8 C 4.5, 12, 8.5, 13, 1' +
          '0.5, 11" fill="none" stroke="white" stroke-width="1.5"/>'#13#10'</svg>' +
          #13#10
      end
      item
        IconName = 'PrivateMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'    <p' +
          'olygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="w' +
          'hite" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ProtectedMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'<path ' +
          'stroke="white" d="M4.5 6 h7 M4.5 10 h7 M6 4.5 v7 M10 4.5 v7" />'#13 +
          #10'</svg>'
      end
      item
        IconName = 'PublicMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'    <p' +
          'olygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="w' +
          'hite" />'#13#10'    <polygon points="7.5,5 8.5,5 8.5,11 7.5,11 " fill=' +
          '"none" stroke="white" />'#13#10'</svg>'
      end
      item
        IconName = 'Attribute1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#d63a3a" d="M2 2h11M' +
          '2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12h1M2' +
          ' 13h1" />'#13#10'<path stroke="#963a3a" d="M13 2h1M13 3h1M13 4h1M13 5h' +
          '1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M3 13h11" /' +
          '>'#13#10'<path stroke="#d6583a" d="M3 3h1M5 3h1M7 3h1M9 3h1M11 3h1M4 4' +
          'h1M6 4h1M8 4h1M10 4h1M12 4h1M3 5h1M5 5h1M7 5h1M9 5h1M11 5h1M4 6h' +
          '1M6 6h1M8 6h1M10 6h1M12 6h1M3 7h1M5 7h1M7 7h1M9 7h1M11 7h1M4 8h1' +
          'M6 8h1M8 8h1M10 8h1M12 8h1M3 9h1M5 9h1M7 9h1M9 9h1M11 9h1M4 10h1' +
          'M6 10h1M8 10h1M10 10h1M12 10h1M3 11h1M5 11h1M7 11h1M9 11h1M11 11' +
          'h1M4 12h1M6 12h1M8 12h1M10 12h1M12 12h1" />'#13#10'<path stroke="#fe77' +
          '3a" d="M4 3h1M6 3h1M8 3h1M10 3h1M12 3h1M3 4h1M5 4h1M7 4h1M9 4h1M' +
          '11 4h1M4 5h1M6 5h1M8 5h1M10 5h1M12 5h1M3 6h1M5 6h1M7 6h1M9 6h1M1' +
          '1 6h1M4 7h1M6 7h1M8 7h1M10 7h1M12 7h1M3 8h1M5 8h1M7 8h1M9 8h1M11' +
          ' 8h1M4 9h1M6 9h1M8 9h1M10 9h1M12 9h1M3 10h1M5 10h1M7 10h1M9 10h1' +
          'M11 10h1M4 11h1M6 11h1M8 11h1M10 11h1M12 11h1M3 12h1M5 12h1M7 12' +
          'h1M9 12h1M11 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Method'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'</svg>' +
          #13#10
      end
      item
        IconName = 'Local'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#676767" d="M3 2h10M' +
          '3 3h2M7 3h6M3 4h2M7 4h6M3 5h2M7 5h6M3 6h2M7 6h6M3 7h2M7 7h6M3 8h' +
          '2M7 8h6M3 9h2M7 9h6M3 10h2M11 10h2M3 11h2M11 11h2M3 12h10" />'#13#10'<' +
          'path stroke="#ffffff" d="M5 3h2M5 4h2M5 5h2M5 6h2M5 7h2M5 8h2M5 ' +
          '9h2M5 10h6M5 11h6" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Parameter'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#676767" d="M3 2h10M' +
          '3 3h2M10 3h3M3 4h2M7 4h2M11 4h2M3 5h2M7 5h3M12 5h1M3 6h2M7 6h2M1' +
          '1 6h2M3 7h2M10 7h3M3 8h2M7 8h6M3 9h2M7 9h6M3 10h2M7 10h6M3 11h2M' +
          '7 11h6M3 12h10" />'#13#10'<path stroke="#ffffff" d="M5 3h4M5 4h2M9 4h1' +
          'M5 5h2M10 5h1M5 6h2M9 6h1M5 7h4M5 8h2M5 9h2M5 10h2M5 11h2" />'#13#10'<' +
          'path stroke="#979797" d="M9 3h1M10 4h1M11 5h1M10 6h1M9 7h1" />'#13#10 +
          '</svg>'#13#10
      end
      item
        IconName = 'ClassEdit'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#95fff8" d="M2 1h11M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="#8eb3dd" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#13#10'<path stroke="#408acc" d="M3 3h10M3 4h2M11 4h2M3 5h2M8 5' +
          'h1M12 5h1M3 6h1M7 6h3M12 6h1M3 7h1M6 7h7M3 8h1M6 8h7M3 9h1M7 9h3' +
          'M12 9h1M3 10h2M8 10h1M12 10h1M3 11h2M11 11h2M3 12h10" />'#13#10'<path ' +
          'stroke="#468dcd" d="M5 4h1M5 11h1" />'#13#10'<path stroke="#a0c5e6" d=' +
          '"M6 4h1" />'#13#10'<path stroke="#f2f7fb" d="M7 4h1" />'#13#10'<path stroke=' +
          '"#cde1f1" d="M8 4h2M8 11h2" />'#13#10'<path stroke="#5497d1" d="M10 4h' +
          '1M10 11h1" />'#13#10'<path stroke="#c1d9ee" d="M5 5h1M5 10h1" />'#13#10'<pat' +
          'h stroke="#b2d0ea" d="M6 5h1M6 10h1" />'#13#10'<path stroke="#488fce" ' +
          'd="M7 5h1M7 10h1" />'#13#10'<path stroke="#73aada" d="M9 5h1" />'#13#10'<pat' +
          'h stroke="#e8f0f8" d="M10 5h1M10 10h1" />'#13#10'<path stroke="#438bcc' +
          '" d="M11 5h1" />'#13#10'<path stroke="#609ed4" d="M4 6h1" />'#13#10'<path st' +
          'roke="#f8fafc" d="M5 6h1M5 9h1M7 11h1" />'#13#10'<path stroke="#4990ce' +
          '" d="M6 6h1M6 9h1M11 10h1" />'#13#10'<path stroke="#70a8da" d="M10 6h1' +
          '" />'#13#10'<path stroke="#5094d0" d="M11 6h1" />'#13#10'<path stroke="#7eb1' +
          'dd" d="M4 7h1" />'#13#10'<path stroke="#d0e3f2" d="M5 7h1M5 8h1" />'#13#10'<' +
          'path stroke="#77acdb" d="M4 8h1" />'#13#10'<path stroke="#5d9cd4" d="M' +
          '4 9h1" />'#13#10'<path stroke="#94bee3" d="M10 9h1" />'#13#10'<path stroke="' +
          '#6da6d8" d="M11 9h1M9 10h1" />'#13#10'<path stroke="#aacbe9" d="M6 11h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Local'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#aaaaaa" d="M3 2h10M' +
          '3 3h2M7 3h6M3 4h2M7 4h6M3 5h2M7 5h6M3 6h2M7 6h6M3 7h2M7 7h6M3 8h' +
          '2M7 8h6M3 9h2M7 9h6M3 10h2M11 10h2M3 11h2M11 11h2M3 12h10"/>'#13#10'<p' +
          'ath stroke="#ffffff" d="M5 3h2M5 4h2M5 5h2M5 6h2M5 7h2M5 8h2M5 9' +
          'h2M5 10h6M5 11h6"/>'#13#10'</svg>'
      end
      item
        IconName = 'Parameter'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#aaaaaa" d="M3 2h10M' +
          '3 3h2M10 3h3M3 4h2M7 4h2M11 4h2M3 5h2M7 5h3M12 5h1M3 6h2M7 6h2M1' +
          '1 6h2M3 7h2M10 7h3M3 8h2M7 8h6M3 9h2M7 9h6M3 10h2M7 10h6M3 11h2M' +
          '7 11h6M3 12h10" />'#13#10'<path stroke="#ffffff" d="M5 3h4M5 4h2M9 4h1' +
          'M5 5h2M10 5h1M5 6h2M9 6h1M5 7h4M5 8h2M5 9h2M5 10h2M5 11h2" />'#13#10'<' +
          'path stroke="#dcdcdc" d="M9 3h1M10 4h1M11 5h1M10 6h1M9 7h1" />'#13#10 +
          '</svg>'#13#10
      end
      item
        IconName = 'Close1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Close1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#ffffff">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Font1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="M186-8' +
          '0q-54 0-80-22t-26-66q0-58 49-74t116-16h21v-56q0-34-1-55.5t-6-35.' +
          '5q-5-14-11.5-19.5T230-430q-9 0-16.5 3t-12.5 8q-4 5-5 10.5t1 11.5' +
          'q6 11 14 21.5t8 24.5q0 25-17.5 42.5T159-291q-25 0-42.5-17.5T99-3' +
          '51q0-27 12-44t32.5-27q20.5-10 47.5-14t58-4q85 0 118 30.5T400-302' +
          'v147q0 19 4.5 28t15.5 9q12 0 19.5-18t9.5-56h11q-3 62-23.5 87T368' +
          '-80q-43 0-67.5-13.5T269-134q-10 29-29.5 41.5T186-80Zm373 0q-20 0' +
          '-32.5-16.5T522-132l102-269q7-17 22-28t34-11q19 0 34 11t22 28l102' +
          ' 269q8 19-4.5 35.5T801-80q-12 0-22-7t-15-19l-20-58H616l-20 58q-4' +
          ' 11-14 18.5T559-80Zm-324-29q13 0 22-20.5t9-49.5v-67q-26 0-38 15.' +
          '5T216-180v11q0 36 4 48t15 12Zm407-125h77l-39-114-38 114Zm-37-285' +
          'q-48 0-76.5-33.5T500-643q0-104 66-170.5T735-880q42 0 68 9.5t26 2' +
          '4.5q0 6-2 12t-7 11q-5 7-12.5 10t-15.5 1q-14-4-32-7t-33-3q-71 0-1' +
          '14 48t-43 127q0 22 8 46t36 24q11 0 21.5-5t18.5-14q17-18 31.5-60T' +
          '712-758q2-13 10.5-18.5T746-782q18 0 27.5 9.5T779-749q-12 43-17.5' +
          ' 75t-5.5 58q0 20 5.5 29t16.5 9q11 0 21.5-8t29.5-30q2-3 15-7 8 0 ' +
          '12 6t4 17q0 28-32 54t-67 26q-26 0-44.5-14T691-574q-15 26-37 40.5' +
          'T605-519Zm-485-1v-220q0-58 41-99t99-41q58 0 99 41t41 99v220h-80v' +
          '-80H200v80h-80Zm80-160h120v-60q0-25-17.5-42.5T260-800q-25 0-42.5' +
          ' 17.5T200-740v60Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Font1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#e6e6e6">'#13#10'  <path d="M186-8' +
          '0q-54 0-80-22t-26-66q0-58 49-74t116-16h21v-56q0-34-1-55.5t-6-35.' +
          '5q-5-14-11.5-19.5T230-430q-9 0-16.5 3t-12.5 8q-4 5-5 10.5t1 11.5' +
          'q6 11 14 21.5t8 24.5q0 25-17.5 42.5T159-291q-25 0-42.5-17.5T99-3' +
          '51q0-27 12-44t32.5-27q20.5-10 47.5-14t58-4q85 0 118 30.5T400-302' +
          'v147q0 19 4.5 28t15.5 9q12 0 19.5-18t9.5-56h11q-3 62-23.5 87T368' +
          '-80q-43 0-67.5-13.5T269-134q-10 29-29.5 41.5T186-80Zm373 0q-20 0' +
          '-32.5-16.5T522-132l102-269q7-17 22-28t34-11q19 0 34 11t22 28l102' +
          ' 269q8 19-4.5 35.5T801-80q-12 0-22-7t-15-19l-20-58H616l-20 58q-4' +
          ' 11-14 18.5T559-80Zm-324-29q13 0 22-20.5t9-49.5v-67q-26 0-38 15.' +
          '5T216-180v11q0 36 4 48t15 12Zm407-125h77l-39-114-38 114Zm-37-285' +
          'q-48 0-76.5-33.5T500-643q0-104 66-170.5T735-880q42 0 68 9.5t26 2' +
          '4.5q0 6-2 12t-7 11q-5 7-12.5 10t-15.5 1q-14-4-32-7t-33-3q-71 0-1' +
          '14 48t-43 127q0 22 8 46t36 24q11 0 21.5-5t18.5-14q17-18 31.5-60T' +
          '712-758q2-13 10.5-18.5T746-782q18 0 27.5 9.5T779-749q-12 43-17.5' +
          ' 75t-5.5 58q0 20 5.5 29t16.5 9q11 0 21.5-8t29.5-30q2-3 15-7 8 0 ' +
          '12 6t4 17q0 28-32 54t-67 26q-26 0-44.5-14T691-574q-15 26-37 40.5' +
          'T605-519Zm-485-1v-220q0-58 41-99t99-41q58 0 99 41t41 99v220h-80v' +
          '-80H200v80h-80Zm80-160h120v-60q0-25-17.5-42.5T260-800q-25 0-42.5' +
          ' 17.5T200-740v60Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'DefaultLayout1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16" >'#13#10'<path stroke="#9e9e9e" d="M0 0h16' +
          'M0 1h1M12 1h1M15 1h1M0 2h1M12 2h1M15 2h1M0 3h1M12 3h1M15 3h1M0 4' +
          'h1M12 4h1M15 4h1M0 5h1M12 5h1M15 5h1M0 6h1M12 6h1M15 6h1M0 7h1M1' +
          '2 7h1M15 7h1M0 8h1M12 8h1M15 8h1M0 9h1M12 9h1M15 9h1M0 10h1M12 1' +
          '0h1M15 10h1M0 11h16M0 12h1M15 12h1M0 13h1M15 13h1M0 14h1M15 14h1' +
          'M0 15h16" />'#13#10'<path stroke="#ffffff" d="M1 1h1M13 1h1M1 3h11M13 ' +
          '3h2M1 4h11M13 4h2M1 5h11M13 5h2M1 6h11M13 6h2M1 7h11M13 7h2M1 8h' +
          '11M13 8h2M1 9h11M13 9h2M1 10h11M13 10h2M1 12h1M1 14h14" />'#13#10'<pat' +
          'h stroke="#00007a" d="M2 1h1M4 1h2M7 1h2M10 1h1M14 1h1M1 2h11M13' +
          ' 2h2M2 12h1M4 12h11M1 13h2M4 13h2M7 13h2M10 13h3M14 13h1" />'#13#10'<p' +
          'ath stroke="#00009a" d="M3 1h1M6 1h1M9 1h1M11 1h1M3 12h1M3 13h1M' +
          '6 13h1M9 13h1M13 13h1" />'#13#10'</svg>'
      end
      item
        IconName = 'Function'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#10'<path stroke="#676767" d="M2 1h12M2' +
          ' 2h12M2 3h4M11 3h3M2 4h4M11 4h3M2 5h4M8 5h6M2 6h4M8 6h6M2 7h4M11' +
          ' 7h3M2 8h4M11 8h3M2 9h4M8 9h6M2 10h4M8 10h6M2 11h4M8 11h6M2 12h4' +
          'M7 12h7M2 13h12" />'#10'<path stroke="#a4a4a4" d="M6 3h1" />'#10'<path s' +
          'troke="#a6a6a6" d="M7 3h3" />'#10'<path stroke="#c0c0c0" d="M10 3h1M' +
          '9 4h1M9 7h1" />'#10'<path stroke="#eeeeee" d="M6 4h1" />'#10'<path strok' +
          'e="#d8d8d8" d="M7 4h1" />'#10'<path stroke="#c5c5c5" d="M8 4h1" />'#10'<' +
          'path stroke="#a1a1a1" d="M10 4h1" />'#10'<path stroke="#ededed" d="M' +
          '6 5h1M6 6h1" />'#10'<path stroke="#969696" d="M7 5h1M7 6h1" />'#10'<path' +
          ' stroke="#ececec" d="M6 7h1M6 8h1M6 9h1M6 10h1" />'#10'<path stroke=' +
          '"#dddddd" d="M7 7h1" />'#10'<path stroke="#c4c4c4" d="M8 7h1" />'#10'<pa' +
          'th stroke="#979797" d="M10 7h1" />'#10'<path stroke="#b7b7b7" d="M7 ' +
          '8h1" />'#10'<path stroke="#989898" d="M8 8h1" />'#10'<path stroke="#9595' +
          '95" d="M9 8h1" />'#10'<path stroke="#7d7d7d" d="M10 8h1" />'#10'<path st' +
          'roke="#919191" d="M7 9h1M7 10h1M7 11h1" />'#10'<path stroke="#ebebeb' +
          '" d="M6 11h1" />'#10'<path stroke="#696969" d="M6 12h1" />'#10'</svg>'
      end
      item
        IconName = 'Function'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#10'<path stroke="#aaaaaa" d="M2 1h12M2' +
          ' 2h12M2 3h4M11 3h3M2 4h4M11 4h3M2 5h4M8 5h6M2 6h4M8 6h6M2 7h4M11' +
          ' 7h3M2 8h4M11 8h3M2 9h4M8 9h6M2 10h4M8 10h6M2 11h4M8 11h6M2 12h4' +
          'M7 12h7M2 13h12" />'#10'<path stroke="#cccccc" d="M6 3h1" />'#10'<path s' +
          'troke="#cdcdcd" d="M7 3h3" />'#10'<path stroke="#dcdcdc" d="M10 3h1M' +
          '9 4h1M9 7h1" />'#10'<path stroke="#f5f5f5" d="M6 4h1" />'#10'<path strok' +
          'e="#eaeaea" d="M7 4h1" />'#10'<path stroke="#dfdfdf" d="M8 4h1M8 7h1' +
          '" />'#10'<path stroke="#cacaca" d="M10 4h1" />'#10'<path stroke="#f4f4f4' +
          '" d="M6 5h1M6 6h1M6 7h1M6 8h1M6 9h1M6 10h1" />'#10'<path stroke="#c5' +
          'c5c5" d="M7 5h1M7 6h1M10 7h1M8 8h1" />'#10'<path stroke="#ececec" d=' +
          '"M7 7h1" />'#10'<path stroke="#d6d6d6" d="M7 8h1" />'#10'<path stroke="#' +
          'c4c4c4" d="M9 8h1" />'#10'<path stroke="#b6b6b6" d="M10 8h1" />'#10'<pat' +
          'h stroke="#c1c1c1" d="M7 9h1M7 10h1M7 11h1" />'#10'<path stroke="#f3' +
          'f3f3" d="M6 11h1" />'#10'<path stroke="#ababab" d="M6 12h1" />'#10'</svg' +
          '>'
      end>
    Left = 192
    Top = 24
  end
  object vilFileStructureLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'EditClass'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PrivateAttribute'
        Name = 'PrivateAttribute'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ProtectedAttribute'
        Name = 'ProtectedAttribute'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PublicAttribute'
        Name = 'PublicAttribute'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Class1'
        Name = 'Class1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'PrivateMethod'
        Name = 'PrivateMethod'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ProtectedMethod'
        Name = 'ProtectedMethod'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PublicMethod'
        Name = 'PublicMethod'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Attribute1'
        Name = 'Attribute1'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Method'
        Name = 'Method'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Local'
        Name = 'Local'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Parameter'
        Name = 'Parameter'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Close1'
        Name = 'Close1'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Font1'
        Name = 'Font1'
      end
      item
        CollectionIndex = 19
        CollectionName = 'DefaultLayout1'
        Name = 'DefaultLayout1'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Function'
        Name = 'Function'
      end>
    ImageCollection = icFileStructure
    Left = 64
    Top = 112
  end
  object vilFileStructureDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 12
        CollectionName = 'ClassEdit'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PrivateAttribute'
        Name = 'PrivateAttribute'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ProtectedAttribute'
        Name = 'ProtectedAttribute'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PublicAttribute'
        Name = 'PublicAttribute'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Class1'
        Name = 'Class1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'PrivateMethod'
        Name = 'PrivateMethod'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ProtectedMethod'
        Name = 'ProtectedMethod'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PublicMethod'
        Name = 'PublicMethod'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Attribute1'
        Name = 'Attribute1'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Method'
        Name = 'Method'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Local'
        Name = 'Local'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Parameter'
        Name = 'Parameter'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Close1'
        Name = 'Close1'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Font1'
        Name = 'Font1'
      end
      item
        CollectionIndex = 19
        CollectionName = 'DefaultLayout1'
        Name = 'DefaultLayout1'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Function'
        Name = 'Function'
      end>
    ImageCollection = icFileStructure
    Left = 184
    Top = 112
  end
end
