-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON 
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[tri_Insert_NarrativeDiagnosis_fromExamination]
   ON [dbo].[DoctorGPDecisionMacking]
   AFTER insert 
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	declare @WaitingID int , @NarrativeDiagnosis  nvarchar(Max)
	select  @WaitingID = VisitID , @NarrativeDiagnosis = NarrativeDiagnosis from inserted
	select @NarrativeDiagnosis = coalesce(@NarrativeDiagnosis,'') +', '+ DoctorDentalExamination.NarrativeExam from DoctorDentalExamination 
	where VisitID = @WaitingID 
	update  DoctorGPDecisionMacking set NarrativeDiagnosis=@NarrativeDiagnosis   where visitid= @WaitingID

END
GO


