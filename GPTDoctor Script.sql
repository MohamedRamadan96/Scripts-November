USE [ClinicPro]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetDoctorGPData_ByFieldTitle]    Script Date: 09/22/2019 17:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author: <Author,,Name>
-- Create date: <Create Date,,>
-- Description: <Description, ,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetDoctorGPData_ByFieldTitle]
@PatientID int,
    @VisitID   int,
    @ReadHistory  smallint =0,
    @FieldTitle  nvarchar(50)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

    -- Insert statements for procedure here
if (@ReadHistory=1)
 Begin
      declare @LastVisitID int
      select @LastVisitID=(select top 1 VisitID from DoctorGPData where patientid=@PatientID and DoctorGPData.VisitID<=@VisitID   order by VisitID desc)
       print @LastVisitID
If (@LastVisitID=@VisitID)
Begin
SELECT   coalesce(DoctorGPData.DoctorGPDataID,0)as  DoctorGPDataID,DoctorGPDataControlGroups.IsHead,DoctorGPDataControlGroups.ControlGroupID,
DoctorGPDataControlGroups.FieldTitle,convert (smallint ,coalesce(DoctorGPData.FieldStatus,3)) as FieldStatusID, DoctorGPDataControlGroups.FieldGroup,
DoctorGPData.PatientID, coalesce(DoctorGPDataControlGroups.ControlName,'Text') as ControlName,
DoctorGPData.VisitID, DoctorGPData.Comment,DoctorGPDataControlGroups.SecondID,DoctorGPDataControlGroups.ChildAffect,DoctorGPDataControlGroups.ParentID
, DoctorGPDataControlGroups.FieldType , DoctorGPDataControlGroups.DropDownGroupID, coalesce(DoctorGPData.LookupID,0) AS LookupID
FROM        DoctorGPDataControlGroups   left outer join DoctorGPData
  ON DoctorGPData.FieldTitle = DoctorGPDataControlGroups.FieldTitle AND
 DoctorGPData.FieldGroup = DoctorGPDataControlGroups.FieldGroup  
                    and (DoctorGPData.VisitID=@LastVisitID  or DoctorGPData.VisitID is null)

WHERE  
 (DoctorGPData.VisitID=@LastVisitID  or DoctorGPData.VisitID is null) and
(DoctorGPData.PatientID=@PatientID or DoctorGPData.PatientID is null)
and (DoctorGPDataControlGroups.FieldGroup = @FieldTitle)
order by DoctorGPDataControlGroups.DispalyOrder
END

Else  -- this mean the visit without history so we need to  Insert History
Begin
                    SELECT   0 as  DoctorGPDataID,DoctorGPDataControlGroups.IsHead,DoctorGPDataControlGroups.ControlGroupID,
DoctorGPDataControlGroups.FieldTitle,convert (smallint ,coalesce(DoctorGPData.FieldStatus,3)) as FieldStatusID, DoctorGPDataControlGroups.FieldGroup,
DoctorGPData.PatientID, coalesce(DoctorGPDataControlGroups.ControlName,'Text') as ControlName,
DoctorGPData.VisitID, DoctorGPData.Comment,DoctorGPDataControlGroups.SecondID,DoctorGPDataControlGroups.ChildAffect,DoctorGPDataControlGroups.ParentID
, DoctorGPDataControlGroups.FieldType, DoctorGPDataControlGroups.DropDownGroupID
FROM        DoctorGPDataControlGroups   left outer join DoctorGPData
  ON DoctorGPData.FieldTitle = DoctorGPDataControlGroups.FieldTitle AND
 DoctorGPData.FieldGroup = DoctorGPDataControlGroups.FieldGroup  
                    and (DoctorGPData.VisitID=@LastVisitID  or DoctorGPData.VisitID is null)

WHERE  
 (DoctorGPData.VisitID=@LastVisitID  or DoctorGPData.VisitID is null) and
(DoctorGPData.PatientID=@PatientID or DoctorGPData.PatientID is null)
and (DoctorGPDataControlGroups.FieldGroup = @FieldTitle)
order by DoctorGPDataControlGroups.DispalyOrder
END
 

 End

Else
Begin
SELECT   coalesce(DoctorGPData.DoctorGPDataID,0)as  DoctorGPDataID,DoctorGPDataControlGroups.IsHead,DoctorGPDataControlGroups.ControlGroupID,
DoctorGPDataControlGroups.FieldTitle,convert (smallint ,coalesce(DoctorGPData.FieldStatus,3)) as FieldStatusID, DoctorGPDataControlGroups.FieldGroup,
DoctorGPData.PatientID, coalesce(DoctorGPDataControlGroups.ControlName,'Text') as ControlName,
DoctorGPData.VisitID, DoctorGPData.Comment,DoctorGPDataControlGroups.SecondID,DoctorGPDataControlGroups.ChildAffect,DoctorGPDataControlGroups.ParentID
, DoctorGPDataControlGroups.FieldType, DoctorGPDataControlGroups.DropDownGroupID, coalesce(DoctorGPData.LookupID,0) AS LookupID
FROM        DoctorGPDataControlGroups   left outer join DoctorGPData
  ON DoctorGPData.FieldTitle = DoctorGPDataControlGroups.FieldTitle AND
--                      DoctorGPData.FieldStatus = DoctorGPDataControlGroups.FieldStatus AND
 DoctorGPData.FieldGroup = DoctorGPDataControlGroups.FieldGroup  
                     and (DoctorGPData.VisitID=@VisitID  or DoctorGPData.VisitID is null)

WHERE  
 (DoctorGPData.VisitID=@VisitID  or DoctorGPData.VisitID is null) and
(DoctorGPData.PatientID=@PatientID or DoctorGPData.PatientID is null)
and (DoctorGPDataControlGroups.FieldGroup = @FieldTitle)


order by DoctorGPDataControlGroups.DispalyOrder

End




END


GO


