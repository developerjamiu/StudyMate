enum Department {
  civilEngineering,
  electricalEngineering,
  mechanicalEngineering,
  computerEngineering,
  mechatronic,
  slt,
  biologyAndMicrobiology,
  appliedChemistry,
  physicsAndElectronics,
  geology,
  computerScience,
  statistics,
  architecture,
  urbanAndRegionalPlanning,
  estateManagement,
  quantitySurveying,
  buildingTechnology,
  paintingAndSculpture,
  industrialDesign,
  graphicAndPainting,
  surveyingAndGeoinformatics,
  accountancy,
  bankingAndFinance,
  insurance,
  massCommunication,
  marketing,
  businessAdministration,
  officeTechnologyManagement,
  purchasingAndProcurement,
  localGovernment,
  publicAdministration,
  musicTechnology,
}

extension DepartmentExtension on Department {
  String get name {
    switch (this) {
      case Department.civilEngineering:
        return 'Civil Engineering';
      case Department.electricalEngineering:
        return 'Electrical Engineering';
      case Department.mechanicalEngineering:
        return 'Mechanical Engineering';
      case Department.computerEngineering:
        return 'Computer Engineering';
      case Department.mechatronic:
        return 'Mechatronic';
      case Department.slt:
        return 'Science Laboratory Technology';
      case Department.biologyAndMicrobiology:
        return 'Biology and Microbiology';
      case Department.appliedChemistry:
        return 'Applied Chemistry';
      case Department.physicsAndElectronics:
        return 'Physics and Electronics';
      case Department.geology:
        return 'Geology';
      case Department.computerScience:
        return 'Computer Science';
      case Department.statistics:
        return 'Statistics';
      case Department.architecture:
        return 'Architecture';
      case Department.urbanAndRegionalPlanning:
        return 'Urban And Regional Planning';
      case Department.estateManagement:
        return 'Estate Management';
      case Department.quantitySurveying:
        return 'Quantity Surveying';
      case Department.buildingTechnology:
        return 'Building Technology';
      case Department.paintingAndSculpture:
        return 'Painting And Sculpture';
      case Department.industrialDesign:
        return 'Industrial Design';
      case Department.graphicAndPainting:
        return 'Graphic And Painting';
      case Department.surveyingAndGeoinformatics:
        return 'Surveying And Geoinformatics';
      case Department.accountancy:
        return 'Accountancy';
      case Department.bankingAndFinance:
        return 'Banking And Finance';
      case Department.insurance:
        return 'Insurance';
      case Department.massCommunication:
        return 'Mass Communication';
      case Department.marketing:
        return 'Marketing';
      case Department.businessAdministration:
        return 'Business Administration';
      case Department.officeTechnologyManagement:
        return 'Office Technology Management';
      case Department.purchasingAndProcurement:
        return 'Purchasing And Procurement';
      case Department.localGovernment:
        return 'Local Government';
      case Department.publicAdministration:
        return 'Public Administration';
      case Department.musicTechnology:
        return 'Music Technology';
    }
  }
}
