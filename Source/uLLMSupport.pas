{ -----------------------------------------------------------------------------
  Unit Name: frmEditor
  Author:    Kiriakos Vlahos, Gerhard R�hner
  Date:
  Purpose:
  History:   Originally Based on SynEdit Demo
  -----------------------------------------------------------------------------}

unit uLLMSupport;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.UITypes,
  System.SysUtils,
  System.Classes,
  System.ImageList,
  System.Actions,
  System.Generics.Collections,
  System.JSON,
  System.JSON.Serializers,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  SynEditTypes,
  SynEdit,
  uEditAppIntfs;

type
  TLLMProvider = (
    llmProviderOpenAI,
    llmProviderGemini,
    llmProviderOllama);

  TEndpointType = (
    etUnsupported,
    etOllamaGenerate,
    etOllamaChat,
    etOpenAICompletion,
    etOpenAIChatCompletion,
    etGemini);

  TLLMSettingsValidation = (
    svValid,
    svModelEmpty,
    svInvalidEndpoint,
    svInvalidModel,
    svAPIKeyMissing);

  TLLMSettings = record
    EndPoint: string;
    ApiKey: string;
    Model: string;
    TimeOut: Integer;
    MaxTokens: Integer;
    SystemPrompt: string;
    function Validate: TLLMSettingsValidation;
    function IsLocal: Boolean;
    function EndpointType: TEndpointType;
  end;

  TLLMProviders = record
    Provider: TLLMProvider;
    OpenAI: TLLMSettings;
    Gemini: TLLMSettings;
    Ollama: TLLMSettings;
  end;

  TLLMSettingsClass = class(TPersistent)
  private
    fEndPoint: string;
    fApiKey: string;
    fModel: string;
    fSystemPrompt: string;
    fTimeOut: Integer;
    fMaxTokens: Integer;
  published
    property EndPoint: string read fEndPoint write fEndPoint;
    property ApiKey: string read fApiKey write fApiKey;
    property Model: string read fModel write fModel ;
    property SystemPrompt: string read fSystemPrompt write fSystemPrompt;
    property TimeOut: Integer read fTimeOut write fTimeOut;
    property MaxTokens: Integer read fMaxTokens write fMaxTokens;
  end;

  TLLMProvidersClass = class(TPersistent)
  private
    fProvider: integer;
    fOpenAI: TLLMSettingsClass;
    fGemini: TLLMSettingsClass;
    fOllama: TLLMSettingsClass;
  public
    constructor Create;
    destructor Destroy; override;
    procedure setFromProviders(Providers: TLLMProviders);
    procedure setToProviders(var Providers: TLLMProviders);
  published
    property Provider: Integer read fProvider write fProvider;
    property OpenAI: TLLMSettingsClass read fOpenAI write fOpenAI;
    property Gemini: TLLMSettingsClass read fGemini write fGemini;
    property Ollama: TLLMSettingsClass read fOllama write fOllama;
  end;

  TQAItem = record
    Prompt: string;
    Answer: string;
    constructor Create(const AQuestion, AnAnswer: string);
  end;

  TChatTopic = record
    Title: string;
    QAItems: TArray<TQAItem>;
  end;
  TChatTopics = TArray<TChatTopic>;

  TOnLLMResponseEvent = procedure(Sender: TObject; const Prompt, Answer: string) of object;
  TOnLLMErrorEvent = procedure(Sender: TObject; const Error: string) of object;

  TLLMBase = class
  private
    FHttpClient: TNetHTTPClient;
    FHttpResponse: IHTTPResponse;
    FSourceStream: TStringStream;
    FOnLLMResponse: TOnLLMResponseEvent;
    FOnLLMError: TOnLLMErrorEvent;
    FLastPrompt: string;
    FEndPointType: TEndpointType;
    procedure OnRequestError(const Sender: TObject; const AError: string);
    procedure OnRequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
    function GetIsBusy: Boolean;
    function GetLLMSettings: TLLMSettings;
  protected
    FSerializer: TJsonSerializer;
    procedure DoResponseCompleted(const AResponse: IHTTPResponse); virtual;
    procedure DoResponseCreated(const AResponse: IHTTPResponse); virtual;
    procedure DoResponseOK(const Msg: string); virtual;
    function RequestParams(const Prompt: string; const Suffix: string = ''): string; virtual; abstract;
    // Gemini support
    procedure AddGeminiSystemPrompt(Params: TJSONObject);
    function GeminiMessage(const Role, Content: string): TJsonObject;
  public
    Providers: TLLMProviders;
    ActiveTopicIndex: Integer;
    ChatTopics: TArray<TChatTopic>;
    function ValidateSettings: TLLMSettingsValidation; virtual;
    function ValidationErrMsg(Validation: TLLMSettingsValidation): string;
    constructor Create;
    destructor Destroy; override;

    procedure Ask(const Prompt: string; const Suffix: string = '');
    procedure CancelRequest;

    property Settings: TLLMSettings read GetLLMSettings;
    property IsBusy: Boolean read GetIsBusy;
    property OnLLMResponse: TOnLLMResponseEvent read FOnLLMResponse write FOnLLMResponse;
    property OnLLMError: TOnLLMErrorEvent read FOnLLMError write FOnLLMError;
  end;

  TLLMChat = class(TLLMBase)
  protected
    procedure DoResponseOK(const Msg: string); override;
    function RequestParams(const Prompt: string; const Suffix: string = ''): string; override;
  public
    ActiveTopicIndex: Integer;
    ChatTopics: TArray<TChatTopic>;
    function ValidateSettings: TLLMSettingsValidation; override;
    constructor Create;

    function ActiveTopic: TChatTopic;
    procedure NextTopic;
    procedure PreviousTopic;
    procedure ClearTopic;
    procedure RemoveTopic;
    procedure NewTopic;

    procedure SaveChat(const FName: string);
    procedure LoadChat(const FName: string);
  end;

  TLLMAssistant = class(TLLMBase)
  private
    FActiveEditor: TCustomSynEdit;
    FCaret: TBufferCoord;
    FSelText: string;
    FStopSequence: TArray<string>;
    procedure DoCancelRequest(Sender: TObject);
  protected
    const MaxPrefixLines = 100;
    const MaxSuffixLines = 50;
    procedure DoResponseCompleted(const AResponse: IHTTPResponse); override;
    procedure DoResponseCreated(const AResponse: IHTTPResponse); override;
    procedure DoResponseOK(const Msg: string); override;
    procedure ShowError(Sender: TObject; const Error: string);
    function RequestParams(const Prompt: string; const Suffix: string = ''): string; override;
  public
    function ValidateSettings: TLLMSettingsValidation; override;
    constructor Create;

    procedure Suggest;
    procedure Optimize;
    procedure FixBugs;
    procedure Explain;
  end;

var
  LLMAssistant: TLLMAssistant;

const
  DefaultSystemPrompt = 'You are my expert python coding assistant.';

  OpenaiChatSettings: TLLMSettings = (
    EndPoint: 'https://api.openai.com/v1/chat/completions';
    ApiKey: '';
    Model: 'gpt-4o';
    //Model: 'gpt-3.5-turbo';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

  OpenaiCompletionSettings: TLLMSettings = (
    EndPoint: 'https://api.openai.com/v1/completions';
    ApiKey: '';
    Model: 'gpt-3.5-turbo-instruct';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: '');

  GeminiSettings: TLLMSettings = (
    EndPoint: 'https://generativelanguage.googleapis.com/v1beta';
    ApiKey: '';
    Model: 'gemini-1.5-flash';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

  OllamaChatSettings: TLLMSettings = (
    EndPoint: 'http://localhost:11434/api/chat';
    ApiKey: '';
    Model: 'codellama';
    //Model: 'codegema';
    //Model: 'starcoder2';
    //Model: 'stable-code';
    TimeOut: 60000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

  OllamaCompletionSettings: TLLMSettings = (
    EndPoint: 'http://localhost:11434/api/generate';
    ApiKey: '';
    Model: 'codellama:code';
    TimeOut: 60000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

implementation

uses
  System.Math,
  System.IOUtils,
  JvGnugettext,
  Vcl.Forms,
  frmSuggest,
  cPyScripterSettings,
  uCommonFunctions;

resourcestring
  sLLMBusy = 'The LLM client is busy.';
  sNoResponse = 'No response from the LLM Server.';
  sNoAPIKey = 'The LLM API key is missing.';
  sNoModel = 'The LLM model has not been set.';
  sUnsupportedEndpoint = 'The LLM endpoint is missing or not supported.';
  sUnsupportedModel = 'The LLM model is not supported.';
  sUnexpectedResponse = 'Unexpected response from the LLM Server.';

function Obfuscate(const s: string): string;
// Reversible string obfuscation using the ROT13 algorithm
var
  I: integer;
begin
  result := s;
  for I := 1 to length(s) do
    case ord(s[I]) of
    ord('A')..ord('M'),ord('a')..ord('m'): result[I] := chr(ord(s[I])+13);
    ord('N')..ord('Z'),ord('n')..ord('z'): result[I] := chr(ord(s[I])-13);
    ord('0')..ord('4'): result[I] := chr(ord(s[I])+5);
    ord('5')..ord('9'): result[I] := chr(ord(s[I])-5);
    end;
end;

{ TLLMBase }

procedure TLLMBase.AddGeminiSystemPrompt(Params: TJSONObject);
begin
  if Settings.SystemPrompt <> '' then
  begin
    var JsonText := TJsonObject.Create();
    JsonText.AddPair('text', Settings.SystemPrompt);

    var JsonParts := TJsonObject.Create();
    JsonParts.AddPair('parts', JsonText);

    Params.AddPair('system_instruction', JsonParts);
  end;
end;

procedure TLLMBase.Ask(const Prompt: string; const Suffix: string = '');
var
  ErrMsg: string;
  Params: string;
begin
  if Prompt = '' then Exit;

  if Assigned(FHttpResponse) then
    ErrMsg := sLLMBusy
  else
  begin
    var Validation := ValidateSettings;
    ErrMsg := ValidationErrMsg(Validation);
  end;

  if ErrMsg <> '' then
  begin
    if Assigned(FOnLLMError) then
      FOnLLMError(Self, ErrMsg);
    Exit;
  end;

  FEndPointType := Settings.EndpointType;
  FHttpClient.ConnectionTimeout := Settings.TimeOut;
  FHttpClient.ResponseTimeout := Settings.TimeOut * 2;

  FLastPrompt := Prompt;
  Params := RequestParams(Prompt, Suffix);

  FSourceStream.Clear;
  FSourceStream.WriteString(Params);
  FSourceStream.Position := 0;

  FHttpClient.CustHeaders.Clear;
  var EndPoint := Settings.EndPoint;
  case FEndPointType of
    etOpenAICompletion, etOpenAIChatCompletion:
      FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + Settings.ApiKey;
    etGemini:
      EndPoint := Format('%s/models/%s:generateContent?key=%s',
        [Settings.EndPoint, Settings.Model, Settings.ApiKey]);
  end;

  FHttpClient.CustomHeaders['Content-Type'] := 'application/json';
  FHttpClient.CustomHeaders['AcceptEncoding'] := 'deflate, gzip;q=1.0, *;q=0.5';
  FHttpResponse := FHttpClient.Post(EndPoint , FSourceStream);
  DoResponseCreated(FHttpResponse);
end;

procedure TLLMBase.CancelRequest;
begin
  if Assigned(FHttpResponse) then
    FHttpResponse.AsyncResult.Cancel;
end;

constructor TLLMBase.Create;
begin
  inherited;
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.OnRequestCompleted := OnRequestCompleted;
  FHttpClient.OnRequestError := OnRequestError;
  FHttpClient.Asynchronous := True;

  FSourceStream := TStringStream.Create('', TEncoding.UTF8);

  FSerializer := TJsonSerializer.Create;
end;

destructor TLLMBase.Destroy;
begin
  FSerializer.Free;
  FSourceStream.Free;
  FHttpClient.Free;
  inherited;
end;

procedure TLLMBase.DoResponseCompleted(const AResponse: IHTTPResponse);
begin
  // Do nothing
end;

procedure TLLMBase.DoResponseCreated(const AResponse: IHTTPResponse);
begin
  // Do Nothing
end;

procedure TLLMBase.DoResponseOK(const Msg: string);
begin
  // Do nothing
end;

function TLLMBase.GeminiMessage(const Role, Content: string): TJsonObject;
begin
  Result := TJsonObject.Create;
  Result.AddPair('role', Role);
  var Parts := TJsonObject.Create;
  Parts.AddPair('text', Content);
  Result.AddPair('parts', Parts);
end;

function TLLMBase.GetIsBusy: Boolean;
begin
  Result := Assigned(FHttpResponse);
end;

function TLLMBase.GetLLMSettings: TLLMSettings;
begin
  case Providers.Provider of
    llmProviderOpenAI: Result := Providers.OpenAI;
    llmProviderOllama: Result := Providers.Ollama;
    llmProviderGemini: Result := Providers.Gemini;
  end;
end;

procedure TLLMBase.OnRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
var
  ResponseData: TBytes;
  ResponseOK: Boolean;
  ErrMsg, Msg: string;
begin
  FHttpResponse := nil;
  DoResponseCompleted(AResponse);
  if AResponse.AsyncResult.IsCancelled then
    Exit;
  ResponseOK := False;
  if AResponse.ContentStream.Size > 0 then
  begin
    SetLength(ResponseData, AResponse.ContentStream.Size);
    AResponse.ContentStream.Read(ResponseData, AResponse.ContentStream.Size);
    var JsonResponse := TJsonValue.ParseJSONValue(ResponseData, 0);
    try
      if not (JsonResponse.TryGetValue('error.message', ErrMsg)
        or JsonResponse.TryGetValue('error', ErrMsg))
      then
        case FEndPointType of
          etOpenAIChatCompletion:
            ResponseOK := JsonResponse.TryGetValue('choices[0].message.content', Msg);
          etOpenAICompletion:
            ResponseOK := JsonResponse.TryGetValue('choices[0].text', Msg);
          etOllamaGenerate:
            ResponseOK := JsonResponse.TryGetValue('response', Msg);
          etOllamaChat:
            ResponseOK := JsonResponse.TryGetValue('message.content', Msg);
          etGemini:
            ResponseOK := JsonResponse.TryGetValue('candidates[0].content.parts[0].text', Msg);
        end;
    finally
      JsonResponse.Free;
    end;
  end else
    ErrMsg := sNoResponse;

  if ResponseOK then
  begin
    DoResponseOK(Msg);
    if Assigned(FOnLLMResponse)  then
      FOnLLMResponse(Self, FLastPrompt, Msg);
  end
  else
  begin
    if ErrMsg = '' then
      ErrMsg := sUnexpectedResponse;
    if Assigned(FOnLLMError) then
      FOnLLMError(Self, ErrMsg);
  end;
end;

procedure TLLMBase.OnRequestError(const Sender: TObject; const AError: string);
begin
  FHttpResponse := nil;
  if Assigned(FOnLLMError) then
    FOnLLMError(Self, AError);
end;

function TLLMBase.ValidateSettings: TLLMSettingsValidation;
begin
  Result := Settings.Validate;
end;

function TLLMBase.ValidationErrMsg(Validation: TLLMSettingsValidation): string;
begin
  case Validation of
    svValid: Result := '';
    svModelEmpty: Result := sNoModel;
    svInvalidEndpoint: Result := sUnsupportedEndpoint;
    svInvalidModel: Result := sUnsupportedModel;
    svAPIKeyMissing: Result := sNoAPIKey;
  end;
end;

{ TLLMChat }

function TLLMChat.ActiveTopic: TChatTopic;
begin
  Result := ChatTopics[ActiveTopicIndex];
end;

procedure TLLMChat.ClearTopic;
begin
  ChatTopics[ActiveTopicIndex] := default(TChatTopic);
end;

constructor TLLMChat.Create;
begin
  inherited;
  Providers.Provider := llmProviderOpenAI;
  Providers.OpenAI := OpenaiChatSettings;
  Providers.Ollama := OllamaChatSettings;
  Providers.Gemini := GeminiSettings;

  ChatTopics := [default(TChatTopic)];
  ActiveTopicIndex := 0;
end;

procedure TLLMChat.DoResponseOK(const Msg: string);
begin
  ChatTopics[ActiveTopicIndex].QAItems := ActiveTopic.QAItems + [TQAItem.Create(FLastPrompt, Msg)];
end;

procedure TLLMChat.LoadChat(const FName: string);
begin
  if FileExists(FName) then
  begin
    ChatTopics :=
      FSerializer.Deserialize<TArray<TChatTopic>>(
      TFile.ReadAllText(FName, TEncoding.UTF8));
    ActiveTopicIndex := High(ChatTopics);
  end;
end;

procedure TLLMChat.NewTopic;
begin
  if Length(ActiveTopic.QAItems) = 0 then
    Exit;
  if Length(ChatTopics[High(ChatTopics)].QAItems) > 0 then
    ChatTopics := ChatTopics + [default(TChatTopic)];
  ActiveTopicIndex := High(ChatTopics);
end;

procedure TLLMChat.NextTopic;
begin
  if ActiveTopicIndex < Length(ChatTopics) - 1 then
    Inc(ActiveTopicIndex);
end;

procedure TLLMChat.PreviousTopic;
begin
  if ActiveTopicIndex > 0 then
    Dec(ActiveTopicIndex);
end;

function TLLMChat.RequestParams(const Prompt: string; const Suffix: string = ''): string;

  function GeminiParams: string;
  begin
    var JSON := TSmartPtr.Make(TJSONObject.Create)();

    // start with the system message
    AddGeminiSystemPrompt(JSON);

    // then add the chat history
    var Contents := TJSONArray.Create;
    for var QAItem in ActiveTopic.QAItems do
    begin
      Contents.Add(GeminiMessage('user', QAItem.Prompt));
      Contents.Add(GeminiMessage('model', QAItem.Answer));
    end;
    // finally add the new prompt
    Contents.Add(GeminiMessage('user', Prompt));
    JSON.AddPair('contents', Contents);

    // now add parameters
    var GenerationConfig := TJsonObject.Create();
    GenerationConfig.AddPair('maxOutputTokens', Settings.MaxTokens);
    JSON.AddPair('generationConfig', GenerationConfig);

    Result := JSON.ToJSON;
  end;

  function NewMessage(const Role, Content: string): TJsonObject;
  begin
    Result := TJsonObject.Create;
    Result.AddPair('role', Role);
    Result.AddPair('content', Content);
  end;

begin
  if FEndPointType = etGemini then
    Exit(GeminiParams);

  var JSON := TSmartPtr.Make(TJSONObject.Create)();
  JSON.AddPair('model', Settings.Model);
  JSON.AddPair('stream', False);

  case FEndPointType of
    etOllamaChat:
      begin
        var Options := TJSONObject.Create;
        Options.AddPair('num_predict', Settings.MaxTokens);
        JSON.AddPair('options', Options);
      end;
    etOpenAIChatCompletion:
      JSON.AddPair('max_tokens', Settings.MaxTokens);
  end;

  var Messages := TJSONArray.Create;
  // start with the system message
  if Settings.SystemPrompt <> '' then
    Messages.Add(NewMessage('system', Settings.SystemPrompt));
  // add the history
  for var QAItem in ActiveTopic.QAItems do
  begin
    Messages.Add(NewMessage('user', QAItem.Prompt));
    Messages.Add(NewMessage('assistant', QAItem.Answer));
  end;
  // finally add the new prompt
  Messages.Add(NewMessage('user', Prompt));

  JSON.AddPair('messages', Messages);

  Result := JSON.ToJSON;
end;

procedure TLLMChat.RemoveTopic;
begin
  Delete(ChatTopics, ActiveTopicIndex, 1);

  if ActiveTopicIndex > High(ChatTopics) then
  begin
    if ActiveTopicIndex > 0 then
      Dec(ActiveTopicIndex)
    else
      ChatTopics := [default(TChatTopic)];
  end;
end;

procedure TLLMChat.SaveChat(const FName: string);
begin
  TFile.WriteAllText(FName, FSerializer.Serialize(ChatTopics));
end;

function TLLMChat.ValidateSettings: TLLMSettingsValidation;
begin
  Result := Settings.Validate;
  if (Result = svValid) and
    not (Settings.EndPointType in [etOllamaChat, etGemini, etOpenAIChatCompletion])
  then
    Result := svInvalidEndpoint;
end;

{ TQAItem }

constructor TQAItem.Create(const AQuestion, AnAnswer: string);
begin
  Self.Prompt := AQuestion;
  Self.Answer := AnAnswer;
end;

{ TLLMSettings }

function TLLMSettings.EndpointType: TEndpointType;
begin
  Result := etUnsupported;
  if Endpoint.Contains('googleapis') then
    Result := etGemini
  else if Endpoint.Contains('openai') then
  begin
    if EndPoint = 'https://api.openai.com/v1/chat/completions' then
      Result := etOpenAIChatCompletion
    else if EndPoint = 'https://api.openai.com/v1/completions' then
      Result := etOpenAICompletion;
  end
  else
  begin
    if Endpoint.EndsWith('api/generate') then
      Result := etOllamaGenerate
    else if Endpoint.EndsWith('api/chat') then
      Result := etOllamaChat;
  end
end;

function TLLMSettings.IsLocal: Boolean;
begin
  Result := EndPoint.Contains('localhost')  or EndPoint.Contains('127.0.0.1');
end;

function TLLMSettings.Validate: TLLMSettingsValidation;
begin
  if Model = '' then
    Exit(svModelEmpty);
  case EndpointType of
    etUnsupported: Exit(svInvalidEndpoint);
    etOpenAICompletion, etOpenAIChatCompletion, etGemini:
      if ApiKey = '' then
        Exit(svAPIKeyMissing);
  end;
  Result := svValid;
end;


{ TLLMAssistant }

procedure TLLMAssistant.Explain;
const
  ExplainPrompt: string =
     'Please analyze the following python code and add detailed python comments ' +
     'and docstrings explaining what each part of the code is doing. '  +
     'The comments should be comprehensive and should help users ' +
     'understand the logic and functionality of the code. ' +
     'Ensure that the explanations and comments are integrated into the source ' +
     'code. The final output should be valid python code.'#$A#$A +
     'Here is the source code that needs comments:'#$A'```'#$A'%s'#$A'```';
begin
  if IsBusy or not Assigned(GI_ActiveEditor) then Exit;

  FActiveEditor := GI_ActiveEditor.ActiveSynEdit;
  FCaret := FActiveEditor.CaretXY;
  FSelText := AdjustLineBreaks(FActiveEditor.SelText, tlbsLF);

  if FSelText = '' then Exit;

  var Prompt := Format(ExplainPrompt, [FSelText]);
  if GetCurrentLanguage = 'de' then
    Prompt:= 'Answer in German. ' + Prompt;

  Ask(Prompt);
end;

constructor TLLMAssistant.Create;
begin
  inherited;
  OnLLMError := ShowError;
  Providers.Provider := llmProviderOpenAI;
  Providers.OpenAI := OpenaiCompletionSettings;
  Providers.Ollama := OllamaCompletionSettings;
  Providers.Gemini := GeminiSettings;
end;

procedure TLLMAssistant.DoCancelRequest(Sender: TObject);
begin
  CancelRequest;
end;

procedure TLLMAssistant.DoResponseCompleted(const AResponse: IHTTPResponse);
begin
  inherited;
  GI_PyIDEServices.SetActivityIndicator(False);
end;

procedure TLLMAssistant.DoResponseCreated(const AResponse: IHTTPResponse);
begin
  inherited;
  GI_PyIDEServices.SetActivityIndicator(True,
    _('Assistant is busy. Click to cancel.'), DoCancelRequest);
end;

procedure TLLMAssistant.DoResponseOK(const Msg: string);

  procedure RemoveLeadingLB(var S: string);
  var
    Count: Integer;
  begin
    Count := 0;
    if S.StartsWith(#13) then
      Inc(Count);
    if S.StartsWith(#10) then
      Inc(Count);
    if Count > 0 then
      S := Copy(S, Count + 1);
  end;

begin
  if not Assigned(GI_ActiveEditor) or
    (FActiveEditor <> GI_ActiveEditor.ActiveSynEdit) or
    (FCaret <> GI_ActiveEditor.ActiveSynEdit.CaretXY) or
    (FSelText <> AdjustLineBreaks(FActiveEditor.SelText, tlbsLF))
  then
    Exit;

  var Code := Msg;
  var CodeStart :=  Pos('```', Code);
  if CodeStart > 0 then
  begin
    Inc(CodeStart, 3);
    var CodeEnd := Pos('```', Code, CodeStart);
    Code := Copy(Code, CodeStart, CodeEnd - CodeStart);
    RemoveLeadingLB(Code);
  end;

  if Code.StartsWith('python') then
  begin
    Code := Copy(Code, 7);
    RemoveLeadingLB(Code);
  end;
  //Code := Code.TrimLeft;
  if Code <> '' then
    ShowSuggestion(Code, GI_ActiveEditor.ActiveSynEdit);
end;

procedure TLLMAssistant.FixBugs;
const
  FixBugsPrompt: string =
    'Please analyze the following python code, identify any bugs, ' +
    'and provide fixes. The response should contain the fixed code ' +
    'and should be complete and ready to run. ' +
    'Along with the fixes, insert detailed python comments explaining the nature ' +
    'of the original issues and how they were resolved.'#$A#$A +
    'Here is the source code that needs fixing:'#$A'```'#$A'%s'#$A'```';
begin
  if IsBusy or not Assigned(GI_ActiveEditor) then Exit;

  FActiveEditor := GI_ActiveEditor.ActiveSynEdit;
  FCaret := FActiveEditor.CaretXY;
  FSelText := AdjustLineBreaks(FActiveEditor.SelText, tlbsLF);

  if FSelText = '' then Exit;

  var Prompt := Format(FixBugsPrompt, [FSelText]);
  if GetCurrentLanguage = 'de' then
    Prompt:= 'Answer in German. ' + Prompt;
  Ask(Prompt);
end;

procedure TLLMAssistant.Optimize;
const
  OptimizePrompt: string =
    'Please analyze the following python code and suggest optimizations to ' +
    'reduce the number of operations during execution. The optimizations '+
    'should maintain the original functionality of the code.'#10#10 +
    'The response should contain only the optimized code ' +
    'and should be complete and ready to run.'#$A#$A +
    'Here is the source code that needs optimization:'#$A'```'#$A'%s'#$A'```';
begin
  if IsBusy or not Assigned(GI_ActiveEditor) then Exit;

  FActiveEditor := GI_ActiveEditor.ActiveSynEdit;
  FCaret := FActiveEditor.CaretXY;
  FSelText := AdjustLineBreaks(FActiveEditor.SelText, tlbsLF);

  if FSelText = '' then Exit;

  var Prompt := Format(OptimizePrompt, [FSelText]);
  if GetCurrentLanguage = 'de' then
    Prompt:= 'Answer in German. ' + Prompt;
  Ask(Prompt);
end;

function TLLMAssistant.RequestParams(const Prompt: string; const Suffix: string = ''): string;
const
  Temperature = 0.2;

  function GeminiParams: string;
  begin
    var JSON := TSmartPtr.Make(TJSONObject.Create)();

    // start with the system message
    AddGeminiSystemPrompt(JSON);

    // Add the prompt
    JSON.AddPair('contents', GeminiMessage('user', Prompt));

    // now add parameters
    var GenerationConfig := TJsonObject.Create();
    GenerationConfig.AddPair('maxOutputTokens', Settings.MaxTokens);
    GenerationConfig.AddPair('temperature', Temperature);
    if Length(FStopSequence) > 0 then
    begin
      var StopArray := TJSONArray.Create;
      for var Term in FStopSequence do
        StopArray.Add(Term);
      GenerationConfig.AddPair('stopSequences', StopArray);
    end;
    JSON.AddPair('generationConfig', GenerationConfig);

    Result := JSON.ToJSON;
  end;

begin
  if FEndPointType = etGemini then
    Exit(GeminiParams);

  var JSON := TSmartPtr.Make(TJSONObject.Create)();
  JSON.AddPair('model', Settings.Model);
  JSON.AddPair('stream', False);
  JSON.AddPair('prompt', Prompt);
  if Suffix <> '' then
    JSON.AddPair('suffix', Suffix
  case FEndPointType of
    etOllamaGenerate:
      begin
        JSON.AddPair('system', Settings.SystemPrompt);

        var Options := TJSONObject.Create;
        if Length(FStopSequence) > 0 then
        begin
          var StopArray := TJSONArray.Create;
          for var Term in FStopSequence do
            StopArray.Add(Term);
          Options.AddPair('stop', StopArray);
        end;
        Options.AddPair('num_predict', Settings.MaxTokens);
        Options.AddPair('temperature', Temperature);
        JSON.AddPair('options', Options);
      end;
    etOpenAICompletion:
      begin
        JSON.AddPair('max_tokens', Settings.MaxTokens);
        JSON.AddPair('temperature', Temperature);
      end;
  end;

  Result := JSON.ToJSON;
end;

procedure TLLMAssistant.ShowError(Sender: TObject; const Error: string);
begin
  GI_PyIDEServices.SetActivityIndicator(False);
  GI_PyIDEServices.WriteStatusMsg(Error);
end;

procedure TLLMAssistant.Suggest;
const
  OpenAISuggestPrompt: string =
    'You are my Python coding assistant.  Please complete the following' +
    ' Python code. Return only the missing part:'#13#10'%s';

  GeminiSuggestPrompt =
    'Please fill the blank indicated by "____" in the following Python code. '+
    'Return only what is missing and nothing else:'#13#10'```%s____%s```';

  function GetPrefix: string;
  begin
    Result := '';
    for var I := Max(0, FCaret.Line - MaxPrefixLines) to FCaret.Line - 2 do
      Result := Result + FActiveEditor.Lines[I] + WideLF;
    Result := Result + Copy(FActiveEditor.Lines[FCaret.Line - 1], 1, FCaret.Char - 1);
  end;

  function GetSuffix: string;
  begin
    Result := Copy(FActiveEditor.Lines[FCaret.Line - 1], FCaret.Char + 1);
    for var I := FCaret.Line to Min(FActiveEditor.Lines.Count - 1, FCaret.Line + MaxSuffixLines) do
      Result := Result + WideLF + FActiveEditor.Lines[I];
  end;

begin
  if IsBusy or not Assigned(GI_ActiveEditor) then Exit;

  FActiveEditor := GI_ActiveEditor.ActiveSynEdit;
  FCaret := FActiveEditor.CaretXY;
  FSelText := FActiveEditor.SelText;

  if FSelText <> '' then Exit;

  case Settings.EndPointType of
    etOpenAICompletion:
      begin
        var Prompt := Format(OpenAISuggestPrompt, [GetPrefix]);
        Ask(Prompt, GetSuffix);
      end;
    etOllamaGenerate:
      begin
        if Settings.Model.StartsWith('codellama') then
          FStopSequence := ['<END>', '<EOD>', '<EOT>'];
        var Prompt := GetPrefix;
        Ask(Prompt, GetSuffix);
        FStopSequence := [];
      end;
    etGemini:
      begin
        FStopSequence := ['____'];
        var Prompt := Format(GeminiSuggestPrompt, [GetPrefix, GetSuffix]);
        Ask(Prompt, '');
        FStopSequence := [];
      end;
  end;
end;

function TLLMAssistant.ValidateSettings: TLLMSettingsValidation;
begin
  Result := Settings.Validate;
  if (Result = svValid) and
    not (Settings.EndPointType in [etOllamaGenerate, etOpenAICompletion, etGemini])
  then
    Result := svInvalidEndpoint;
end;

constructor TLLMProvidersClass.Create;
begin
  OpenAI:= TLLMSettingsClass.Create;
  Gemini:= TLLMSettingsClass.Create;
  Ollama:= TLLMSettingsClass.Create;
end;

destructor TLLMProvidersClass.Destroy;
begin
  OpenAI.Free;
  Gemini.Free;
  Ollama.Free;
end;

procedure TLLMProvidersClass.setFromProviders(Providers: TLLMProviders);

  procedure setFromProvider(Provider: TLLMSettingsClass; Settings: TLLMSettings);
  begin
    Provider.EndPoint:=  Settings.EndPoint;
    Provider.ApiKey:= Obfuscate(Settings.ApiKey);
    Provider.Model:= Settings.Model;
    Provider.SystemPrompt:= Settings.SystemPrompt;
    Provider.Timeout:= Settings.Timeout;
    Provider.MaxTokens:= Settings.MaxTokens;
  end;

begin
  Provider:= Integer(Providers.Provider);
  setFromProvider(OpenAI, Providers.OpenAI);
  setFromProvider(Gemini, Providers.Gemini);
  setFromProvider(Ollama, Providers.Ollama);
end;

procedure TLLMProvidersClass.setToProviders(var Providers: TLLMProviders);

  procedure setToProvider(Provider: TLLMSettingsClass; var Settings: TLLMSettings);
  begin
    Settings.EndPoint:= Provider.EndPoint;
    Settings.ApiKey:= Obfuscate(Provider.ApiKey);
    Settings.Model:= Provider.Model;
    Settings.SystemPrompt:= Provider.SystemPrompt;
    Settings.Timeout:= Provider.Timeout;
    Settings.MaxTokens:= Provider.MaxTokens;
  end;

begin
  Providers.Provider:= TLLMProvider(Provider);
  setToProvider(OpenAI, Providers.OpenAI);
  setToProvider(Gemini, Providers.Gemini);
  setToProvider(Ollama, Providers.Ollama);
end;

initialization
  LLMAssistant := TLLMAssistant.Create;

finalization
  LLMAssistant.Free;
end.
