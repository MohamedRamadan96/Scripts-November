update DoctorGPData set DoctorGPData.SecondID=DoctorGPDataControlGroups.SecondID,
             DoctorGPData.ParentID=DoctorGPDataControlGroups.ParentID,
 DoctorGPData.IsHead=DoctorGPDataControlGroups.IsHead,
   DoctorGPData.ControlGroupID=DoctorGPDataControlGroups.ControlGroupID,
DoctorGPData.DropDownGroupID=DoctorGPDataControlGroups.DropDownGroupID,
DoctorGPData.ChildAffect=DoctorGPDataControlGroups.ChildAffect,
DoctorGPData.DermaGroup=DoctorGPDataControlGroups.DermaGroup,

DoctorGPData.ControlName=DoctorGPDataControlGroups.ControlName,
DoctorGPData.DispalyOrder=DoctorGPDataControlGroups.DispalyOrder,
DoctorGPData.FieldType=DoctorGPDataControlGroups.FieldType




from DoctorGPData inner join DoctorGPDataControlGroups  on
DoctorGPDataControlGroups.FieldTitle=DoctorGPData.FieldTitle and
DoctorGPData.FieldGroup=DoctorGPDataControlGroups.FieldGroup
