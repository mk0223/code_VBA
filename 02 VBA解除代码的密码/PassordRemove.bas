Attribute VB_Name = "ģ��1"
Option Explicit

'ʹ�ñ�����֮ǰ��Ҫ����Ҫ������뱣���ĺ��к��Excel�ļ��������xlsm�ļ�����Ҫ�����Ϊ97-03���xls�ļ����ر�
'�½�һ��Excel������,Alt+F11 ��VBA�༭��,�½�һ��ģ�� ,�������´���
'�Ƴ�VBA���뱣��
Sub MoveProtect()
    Dim FileName As String
    FileName = Application.GetOpenFilename("Excel�ļ���*.xls & *.xla��,*.xls;*.xla", , "VBA�ƽ�")
    If FileName = CStr(False) Then
       Exit Sub
    Else
       VBAPassword FileName, False
    End If
End Sub
 
'����VBA���뱣��
Sub SetProtect()
    Dim FileName As String
    FileName = Application.GetOpenFilename("Excel�ļ���*.xls & *.xla��,*.xls;*.xla", , "VBA�ƽ�")
    If FileName = CStr(False) Then
       Exit Sub
    Else
       VBAPassword FileName, True
    End If
End Sub
 
Private Function VBAPassword(FileName As String, Optional Protect As Boolean = False)
      If Dir(FileName) = "" Then
         Exit Function
      Else
         FileCopy FileName, FileName & ".bak"
      End If
 
      Dim GetData As String * 5
      Open FileName For Binary As #1
      Dim CMGs As Long
      Dim DPBo As Long
      Dim i As Long
      For i = 1 To LOF(1)
          Get #1, i, GetData
          If GetData = "CMG=""" Then CMGs = i
          If GetData = "[Host" Then DPBo = i - 2: Exit For
      Next
      If CMGs = 0 Then
         MsgBox "���ȶ�VBA��������һ����������...", 32, "��ʾ"
         Exit Function
      End If
      If Protect = False Then
         Dim St As String * 2
         Dim s20 As String * 1
         'ȡ��һ��0D0Aʮ�������ִ�
         Get #1, CMGs - 2, St
         'ȡ��һ��20ʮ�����ִ�
         Get #1, DPBo + 16, s20
         '�滻���ܲ��ݻ���
         For i = CMGs To DPBo Step 2
             Put #1, i, St
         Next
         '���벻��Է���
         If (DPBo - CMGs) Mod 2 <> 0 Then
            Put #1, DPBo + 1, s20
         End If
         MsgBox "�ļ����ܳɹ�......", 32, "��ʾ"
      Else
         Dim MMs As String * 5
         MMs = "DPB="""
         Put #1, CMGs, MMs
         MsgBox "���ļ�������ܳɹ�......", 32, "��ʾ"
      End If
      Close #1
End Function
