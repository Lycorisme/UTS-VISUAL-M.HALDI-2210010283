program fiture_satuan;

uses
  Forms,
  Unit1 in 'Unit1.pas' {DataModule1: TDataModule},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
