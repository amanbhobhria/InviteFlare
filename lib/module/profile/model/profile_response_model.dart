class ProfileResponseModel {
  dynamic name;
  dynamic email;
  dynamic contact;
  dynamic profileImage;
  dynamic twoFactor;
  dynamic promotionalEmail;
  dynamic collectRsvp;
  dynamic rsvpConfirmation;
  dynamic reminderEmails;

  ProfileResponseModel(
      {this.name,
      this.email,
      this.contact,
      this.profileImage,
      this.twoFactor,
      this.promotionalEmail,
      this.collectRsvp,
      this.rsvpConfirmation,
      this.reminderEmails});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    profileImage = json['profile_image'];
    twoFactor = json['two_factor'];
    promotionalEmail = json['promotional_email'];
    collectRsvp = json['collect_rsvp'];
    rsvpConfirmation = json['rsvp_confirmation'];
    reminderEmails = json['reminder_emails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['profile_image'] = this.profileImage;
    data['two_factor'] = this.twoFactor;
    data['promotional_email'] = this.promotionalEmail;
    data['collect_rsvp'] = this.collectRsvp;
    data['rsvp_confirmation'] = this.rsvpConfirmation;
    data['reminder_emails'] = this.reminderEmails;
    return data;
  }
}