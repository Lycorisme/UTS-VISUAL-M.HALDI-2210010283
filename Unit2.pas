unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Edit3Change(Sender: TObject);
    procedure posisiawal;
    procedure bersih;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  a: string;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  // Mengatur lebar kolom secara manual
  DBGrid1.Columns[0].Width := 30; // Kolom pertama
  DBGrid1.Columns[1].Width := 100; // Kolom kedua
  DBGrid1.Columns[2].Width := 228; // Kolom ketiga
  // Lanjutkan untuk kolom lainnya jika diperlukan

  // Set DefaultDrawing ke True
  DBGrid1.DefaultDrawing := True;

  // Koneksi ke database
  try
    DataModule1.ZConnection.Connect;
  except
    on E: Exception do
      ShowMessage('Gagal terhubung ke database: ' + E.Message);
  end;

  // Aktifkan ZQuery
  DataModule1.Zsatuan.Active := True;
  DBGrid1.DataSource := DataModule1.dssatuan; // Hubungkan DBGrid1 dengan DataSource

  posisiawal;
  Edit3.Enabled := True; // Aktifkan Edit3
end;

procedure TForm2.posisiawal;
begin
  bersih;
  Button1.Enabled := True;
  Button2.Enabled := False;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Button5.Enabled := False;
  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := True; // Pastikan Edit3 selalu aktif
end;

procedure TForm2.bersih;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Button2.Enabled := True;
  Button5.Enabled := True;
  Button1.Enabled := False;
  Edit1.SetFocus; // Pindahkan fokus ke Edit1
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('Nama Tidak Boleh Kosong!');
  end
  else if DataModule1.Zsatuan.Locate('nama', Edit1.Text, []) then
  begin
    ShowMessage('Nama ' + Edit1.Text + ' Sudah Ada Didalam Sistem');
  end
  else
  begin
    try
      with DataModule1.Zsatuan do
      begin
        SQL.Clear;
        SQL.Add('insert into satuan (nama, deskripsi) values ("' + Edit1.Text + '", "' + Edit2.Text + '")');
        ExecSQL;
        SQL.Clear;
        SQL.Add('select * from satuan');
        Open;
      end;
      ShowMessage('Data Berhasil Disimpan!');
      // Refresh DBGrid untuk menampilkan data yang baru
      DataModule1.Zsatuan.Refresh;
      posisiawal;
    except
      on E: Exception do
        ShowMessage('Gagal menyimpan data: ' + E.Message);
    end;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('Nama Tidak Boleh Kosong!');
  end
  else
  begin
    try
      with DataModule1.Zsatuan do
      begin
        SQL.Clear;
        SQL.Add('update satuan set nama="' + Edit1.Text + '", deskripsi="' + Edit2.Text + '" where id="' + a + '"');
        ExecSQL;
        SQL.Clear;
        SQL.Add('select * from satuan');
        Open;
      end;
      ShowMessage('Data Berhasil Diupdate!');
      posisiawal;
    except
      on E: Exception do
        ShowMessage('Gagal mengupdate data: ' + E.Message);
    end;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  if MessageDlg('Apakah Anda Yakin Menghapus Data ini', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      with DataModule1.Zsatuan do
      begin
        SQL.Clear;
        SQL.Add('delete from satuan where id="' + a + '"');
        ExecSQL;
        SQL.Clear;
        SQL.Add('select * from satuan');
        Open;
      end;
      ShowMessage('Data Berhasil Dihapus!');
      posisiawal;
    except
      on E: Exception do
        ShowMessage('Gagal menghapus data: ' + E.Message);
    end;
  end
  else
  begin
    ShowMessage('Data Batal Dihapus!');
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  posisiawal;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
begin
  Edit1.Text := DataModule1.Zsatuan.FieldByName('nama').AsString;
  Edit2.Text := DataModule1.Zsatuan.FieldByName('deskripsi').AsString;
  a := DataModule1.Zsatuan.FieldByName('id').AsString;

  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  Button3.Enabled := True;
  Button4.Enabled := True;
  Button5.Enabled := True;
  Button1.Enabled := False;
  Button2.Enabled := False;
end;

procedure TForm2.Edit3Change(Sender: TObject);
begin
  with DataModule1.Zsatuan do
  begin
    SQL.Clear;
    SQL.Add('select * from satuan where nama like "%' + Edit3.Text + '%"');
    Open;
  end;
end;

end.

