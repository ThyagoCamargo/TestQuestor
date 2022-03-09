object Form1: TForm1
  Left = 0
  Top = 0
  Action = Action1
  Caption = 'Teste Questor'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClick = Action1Execute
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnInsereClientes: TButton
    Left = 360
    Top = 8
    Width = 113
    Height = 25
    Caption = 'Insere 5 Clientes'
    TabOrder = 0
    OnClick = btnInsereClientesClick
  end
  object gbxConexaoBanco: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 289
    Caption = 'Dados para conex'#227'o banco de dados'
    TabOrder = 1
    object edtUsuarioBanco: TLabeledEdit
      Left = 5
      Top = 33
      Width = 313
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = 'UserName'
      TabOrder = 0
    end
    object edtSenhaBanco: TLabeledEdit
      Left = 5
      Top = 72
      Width = 313
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'PassWord'
      TabOrder = 1
    end
    object edtLibName: TLabeledEdit
      Left = 5
      Top = 190
      Width = 313
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = 'LibraryName'
      TabOrder = 2
      Text = 'dbxint30.dll'
    end
    object edtVendorLib: TLabeledEdit
      Left = 5
      Top = 151
      Width = 313
      Height = 21
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Caption = 'VendorLib'
      TabOrder = 3
      Text = 'fbclient.dll'
    end
    object btnTestaConexao: TButton
      Left = 195
      Top = 257
      Width = 121
      Height = 25
      Caption = 'Testar Conex'#227'o'
      TabOrder = 4
      OnClick = btnTestaConexaoClick
    end
    object edtCaminhoBanco: TLabeledEdit
      Left = 5
      Top = 111
      Width = 313
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = 'Caminho Banco'
      TabOrder = 5
      Text = '..\DataBase\TESTE.fdb'
    end
    object edtDriverFunc: TLabeledEdit
      Left = 5
      Top = 229
      Width = 313
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'DriverFunc'
      TabOrder = 6
      Text = 'getSQLDriverINTERBASE'
    end
  end
  object btnInsereVeiculos: TButton
    Left = 479
    Top = 8
    Width = 113
    Height = 25
    Caption = 'Insere 5 Veiculos'
    TabOrder = 2
    OnClick = btnInsereVeiculosClick
  end
  object btnVender: TButton
    Left = 360
    Top = 39
    Width = 113
    Height = 25
    Caption = 'Realiza Vendas'
    TabOrder = 3
    OnClick = btnVenderClick
  end
  object SQLConnection1: TSQLConnection
    LoginPrompt = False
    Left = 416
    Top = 120
  end
  object ActionList1: TActionList
    Left = 384
    Top = 200
    object Action1: TAction
      Caption = 'Teste Questor'
      OnExecute = Action1Execute
      OnUpdate = Action1Update
    end
  end
end
