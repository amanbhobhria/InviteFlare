

mixin MockData {
  static List<Map<String, dynamic>> categories = [
    {
      'id': 1,
      'name': 'Baby & Kids',
      'icon':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/baby-shower.svg',
      'cardColor': 0xFFFFF5E3,
    },
    {
      'id': 2,
      'name': 'Birthday',
      'icon':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/birthday.svg',
      'cardColor': 0xFFF4F4FF,
    },
    {
      'id': 3,
      'name': 'Wedding',
      'icon':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/wedding.svg',
      'cardColor': 0xFFFFF2F4,
    },
    {
      'id': 3,
      'name': 'New Year',
      'icon':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/new-year.svg',
      'cardColor': 0xFFEAFFF8,
    },
  ];

  static String get promoBanner =>
      'https://i.etsystatic.com/37453633/r/il/31d8ce/4499418693/il_570xN.4499418693_5hzg.jpg';

  static Map<String, dynamic> get expandableBirthday => {
        'heading': 'Birthday',
        'description': '''
Fill their inbox with cheer with Christmas cards you can email, text, or share''',
        'cards': [
          {
            'image':
                'https://images.greetingsisland.com/images/invitations/birthday/kids/previews/celebrate-with-us-22601.jpeg?auto=format,compress',
            'name': 'Celebrate with us',
          },
          {
            'image':
                'https://marketplace.canva.com/EAF30pqerkY/1/0/1143w/canva-gold-and-black-birthday-party-invitation-portrait-qam3ouC3JPY.jpg',
            'name': 'Party Zone',
          },
          {
            'image':
                'https://i.pinimg.com/736x/b6/16/af/b616af2a4183a44ba4e34ccde13ac639.jpg',
            'name': 'Glitter Bubbly',
          },
        ]
      };

  static Map<String, dynamic> get explainerSection => {
        'heading': 'Create Stunning Invitations in Just 3 Simple Steps',
        'section': [
          {
            'step': 'Step-1',
            'title': 'Choose the Perfect Design',
            'subTitle': '''
Browse stunning templates for every occasion, perfectly crafted for you.''',
            'lottieJson': 'assets/lottie/envelope-and-letter.json',
            'colorBg': 0x3499BCE9,
          },
          {
            'step': 'Step-2',
            'title': 'Make It Uniquely Yours',
            'subTitle': '''
Personalize colors, text, and photos to match your celebration theme.''',
            'lottieJson': 'assets/lottie/greeting-card.json',
            'colorBg': 0x13ED6157,
          },
          {
            'step': 'Step-3',
            'title': 'Share the Joy',
            'subTitle': '''
Send invitations instantly online or download for printing with ease.''',
            'lottieJson': 'assets/lottie/sending-letter.json',
            'colorBg': 0xFFFCF1E6,
          },
        ]
      };


  static List<Map<String, dynamic>> get categoriesNav => [
        {
          'id': 1,
          'name': 'Birthday',
          'bg_color': '#F2F2FF',
          'icon':
              'https://paperpost-ce6b5.web.app/assets/images/home-category/birthday.svg',
        },
        {
          'id': 2,
          'name': 'Wedding',
          'bg_color': '#FFF6F7',
          'icon':
              'https://paperpost-ce6b5.web.app/assets/images/home-category/wedding.svg',
        },
        {
          'id': 3,
          'name': 'Baby Shower',
          'bg_color': '#F1F7FF',
          'icon':
              'https://paperpost-ce6b5.web.app/assets/images/home-category/baby-shower.svg',
        },
        {
          'id': 4,
          'name': 'Graduation',
          'bg_color': '#ECFFF7',
          'icon':
              'https://paperpost-ce6b5.web.app/assets/images/home-category/graduation.svg',
        },
        {
          'id': 5,
          'name': 'New Year',
          'bg_color': '#FFF9F0',
          'icon':
              'https://paperpost-ce6b5.web.app/assets/images/home-category/new-year.svg',
        }
      ];

  static Map<String, dynamic> get subcategoriesAndFilterEntity => {
        'title': 'Birthday',
        'slug': 'birthday',
        'icon_xs': null,
        'icon_xl': null,
        'bg_color': null,
        'nav_link': '/invitations/birthday',
        'attributes': [
          {
            'name': 'Color',
            'values': [
              {'name': 'Black', 'value': 'black', 'rgb': '000000'},
              {'name': 'Yellow', 'value': 'yellow', 'rgb': 'F4E452'},
              {'name': 'Cream', 'value': 'cream', 'rgb': 'EFE9CC'}
            ]
          },
          {
            'name': 'Theme',
            'values': [
              {'name': 'Classic', 'value': 'classic', 'rgb': null}
            ]
          },
          {
            'name': 'Type',
            'values': [
              {'name': 'Free', 'value': 'free', 'rgb': null},
              {'name': 'Premium', 'value': 'premium', 'rgb': null}
            ]
          },
          {
            'name': 'Sort By',
            'values': [
              {'name': 'Latest', 'value': 'latest', 'rgb': null},
              {'name': 'Popular', 'value': 'popular', 'rgb': null}
            ]
          }
        ],
        'banner': {
          'title': 'Birthday Invitations',
          'sub_title': 'Celebrate every special moment.',
          'description':
              'Make birthdays unforgettable with our vibrant invitations.',
          'background_color': '#fbf6ee'
        },
        'seo': {
          'meta_title': 'Birthday Invitations',
          'meta_description':
              'Find the perfect birthday invitation for all ages and themes. Explore our collection of fun, unique, and themed birthday invitations.',
          'page_title': 'Birthday Invitations',
          'page_description':
              'Celebrate every birthday in style! Choose from our range of personalized invitations to make the day extra special.',
          'canonical_url': '/categories/birthday'
        },
        'category': [
          {
            'title': 'Kids Birthday',
            'slug': 'kids-birthday',
            'icon_xs': null,
            'icon_xl': null,
            'bg_color': null,
            'nav_link': '/invitations/kids-birthday'
          },
          {
            'title': 'Adult Birthday',
            'slug': 'adult-birthday',
            'icon_xs': null,
            'icon_xl': null,
            'bg_color': null,
            'nav_link': '/invitations/adult-birthday'
          },
          {
            'title': 'Themed Birthday',
            'slug': 'themed-birthday',
            'icon_xs': null,
            'icon_xl': null,
            'bg_color': null,
            'nav_link': '/invitations/themed-birthday'
          },
          {
            'title': 'Funny Birthday',
            'slug': 'funny-birthday',
            'icon_xs': null,
            'icon_xl': null,
            'bg_color': null,
            'nav_link': '/invitations/funny-birthday'
          },
          {
            'title': 'For her',
            'slug': 'invitation-for-her',
            'icon_xs': null,
            'icon_xl': null,
            'bg_color': null,
            'nav_link': '/invitations/invitation-for-her'
          }
        ]
      };

  static String get cardDescription =>
      'Find the perfect birthday invitation for all ages and themes. Explore our collection of fun, unique, and themed birthday invitations';

  static List<String> get cardOffers => [
        'Unlimited free downloads',
        'Free link invite sharing',
        'Collect RSVPs and track responses in real-time',
        'Customizable fonts, colors, and layouts',
        'Eco-friendly and paperless designs',
        'Priority customer support for subscribers',
        'Perfect sizes for social media stories and posts'
      ];
}
