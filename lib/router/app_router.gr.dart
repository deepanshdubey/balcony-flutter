// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ConciergeHomePage]
class ConciergeHomeRoute extends PageRouteInfo<void> {
  const ConciergeHomeRoute({List<PageRouteInfo>? children})
      : super(
          ConciergeHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConciergeHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConciergeHomePage();
    },
  );
}

/// generated route for
/// [ConciergeTenantDetailsPage]
class ConciergeTenantDetailsRoute
    extends PageRouteInfo<ConciergeTenantDetailsRouteArgs> {
  ConciergeTenantDetailsRoute({
    Key? key,
    ConciergeTenant? conciergeTenant,
    required String type,
    required VoidCallback onCountUpdated,
    List<PageRouteInfo>? children,
  }) : super(
          ConciergeTenantDetailsRoute.name,
          args: ConciergeTenantDetailsRouteArgs(
            key: key,
            conciergeTenant: conciergeTenant,
            type: type,
            onCountUpdated: onCountUpdated,
          ),
          initialChildren: children,
        );

  static const String name = 'ConciergeTenantDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConciergeTenantDetailsRouteArgs>();
      return ConciergeTenantDetailsPage(
        key: args.key,
        conciergeTenant: args.conciergeTenant,
        type: args.type,
        onCountUpdated: args.onCountUpdated,
      );
    },
  );
}

class ConciergeTenantDetailsRouteArgs {
  const ConciergeTenantDetailsRouteArgs({
    this.key,
    this.conciergeTenant,
    required this.type,
    required this.onCountUpdated,
  });

  final Key? key;

  final ConciergeTenant? conciergeTenant;

  final String type;

  final VoidCallback onCountUpdated;

  @override
  String toString() {
    return 'ConciergeTenantDetailsRouteArgs{key: $key, conciergeTenant: $conciergeTenant, type: $type, onCountUpdated: $onCountUpdated}';
  }
}

/// generated route for
/// [CreatePropertyPage]
class CreatePropertyRoute extends PageRouteInfo<CreatePropertyRouteArgs> {
  CreatePropertyRoute({
    Key? key,
    PropertyData? existingProperty,
    VoidCallback? onEdited,
    List<PageRouteInfo>? children,
  }) : super(
          CreatePropertyRoute.name,
          args: CreatePropertyRouteArgs(
            key: key,
            existingProperty: existingProperty,
            onEdited: onEdited,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatePropertyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePropertyRouteArgs>(
          orElse: () => const CreatePropertyRouteArgs());
      return CreatePropertyPage(
        key: args.key,
        existingProperty: args.existingProperty,
        onEdited: args.onEdited,
      );
    },
  );
}

class CreatePropertyRouteArgs {
  const CreatePropertyRouteArgs({
    this.key,
    this.existingProperty,
    this.onEdited,
  });

  final Key? key;

  final PropertyData? existingProperty;

  final VoidCallback? onEdited;

  @override
  String toString() {
    return 'CreatePropertyRouteArgs{key: $key, existingProperty: $existingProperty, onEdited: $onEdited}';
  }
}

/// generated route for
/// [CreateWorkspacePage]
class CreateWorkspaceRoute extends PageRouteInfo<CreateWorkspaceRouteArgs> {
  CreateWorkspaceRoute({
    Key? key,
    WorkspaceData? editWorkspaceItem,
    VoidCallback? onEdited,
    List<PageRouteInfo>? children,
  }) : super(
          CreateWorkspaceRoute.name,
          args: CreateWorkspaceRouteArgs(
            key: key,
            editWorkspaceItem: editWorkspaceItem,
            onEdited: onEdited,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateWorkspaceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateWorkspaceRouteArgs>(
          orElse: () => const CreateWorkspaceRouteArgs());
      return CreateWorkspacePage(
        key: args.key,
        editWorkspaceItem: args.editWorkspaceItem,
        onEdited: args.onEdited,
      );
    },
  );
}

class CreateWorkspaceRouteArgs {
  const CreateWorkspaceRouteArgs({
    this.key,
    this.editWorkspaceItem,
    this.onEdited,
  });

  final Key? key;

  final WorkspaceData? editWorkspaceItem;

  final VoidCallback? onEdited;

  @override
  String toString() {
    return 'CreateWorkspaceRouteArgs{key: $key, editWorkspaceItem: $editWorkspaceItem, onEdited: $onEdited}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [HostHomePage]
class HostHomeRoute extends PageRouteInfo<void> {
  const HostHomeRoute({List<PageRouteInfo>? children})
      : super(
          HostHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HostHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HostHomePage();
    },
  );
}

/// generated route for
/// [MaintenanceDetailsPage]
class MaintenanceDetailsRoute
    extends PageRouteInfo<MaintenanceDetailsRouteArgs> {
  MaintenanceDetailsRoute({
    Key? key,
    required Request? request,
    List<PageRouteInfo>? children,
  }) : super(
          MaintenanceDetailsRoute.name,
          args: MaintenanceDetailsRouteArgs(
            key: key,
            request: request,
          ),
          initialChildren: children,
        );

  static const String name = 'MaintenanceDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaintenanceDetailsRouteArgs>();
      return MaintenanceDetailsPage(
        key: args.key,
        request: args.request,
      );
    },
  );
}

class MaintenanceDetailsRouteArgs {
  const MaintenanceDetailsRouteArgs({
    this.key,
    required this.request,
  });

  final Key? key;

  final Request? request;

  @override
  String toString() {
    return 'MaintenanceDetailsRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [MaintenanceFormPage]
class MaintenanceFormRoute extends PageRouteInfo<void> {
  const MaintenanceFormRoute({List<PageRouteInfo>? children})
      : super(
          MaintenanceFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'MaintenanceFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MaintenanceFormPage();
    },
  );
}

/// generated route for
/// [OngoingFormPage]
class OngoingFormRoute extends PageRouteInfo<void> {
  const OngoingFormRoute({List<PageRouteInfo>? children})
      : super(
          OngoingFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'OngoingFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OngoingFormPage();
    },
  );
}

/// generated route for
/// [OutgoingParcelDetailsPage]
class OutgoingParcelDetailsRoute
    extends PageRouteInfo<OutgoingParcelDetailsRouteArgs> {
  OutgoingParcelDetailsRoute({
    Key? key,
    required Parcel? parcel,
    List<PageRouteInfo>? children,
  }) : super(
          OutgoingParcelDetailsRoute.name,
          args: OutgoingParcelDetailsRouteArgs(
            key: key,
            parcel: parcel,
          ),
          initialChildren: children,
        );

  static const String name = 'OutgoingParcelDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OutgoingParcelDetailsRouteArgs>();
      return OutgoingParcelDetailsPage(
        key: args.key,
        parcel: args.parcel,
      );
    },
  );
}

class OutgoingParcelDetailsRouteArgs {
  const OutgoingParcelDetailsRouteArgs({
    this.key,
    required this.parcel,
  });

  final Key? key;

  final Parcel? parcel;

  @override
  String toString() {
    return 'OutgoingParcelDetailsRouteArgs{key: $key, parcel: $parcel}';
  }
}

/// generated route for
/// [PlansPage]
class PlansRoute extends PageRouteInfo<void> {
  const PlansRoute({List<PageRouteInfo>? children})
      : super(
          PlansRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlansRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return PlansPage();
    },
  );
}

/// generated route for
/// [PropertyDetailPage]
class PropertyDetailRoute extends PageRouteInfo<PropertyDetailRouteArgs> {
  PropertyDetailRoute({
    Key? key,
    String? propertyId,
    List<PageRouteInfo>? children,
  }) : super(
          PropertyDetailRoute.name,
          args: PropertyDetailRouteArgs(
            key: key,
            propertyId: propertyId,
          ),
          initialChildren: children,
        );

  static const String name = 'PropertyDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PropertyDetailRouteArgs>(
          orElse: () => const PropertyDetailRouteArgs());
      return PropertyDetailPage(
        key: args.key,
        propertyId: args.propertyId,
      );
    },
  );
}

class PropertyDetailRouteArgs {
  const PropertyDetailRouteArgs({
    this.key,
    this.propertyId,
  });

  final Key? key;

  final String? propertyId;

  @override
  String toString() {
    return 'PropertyDetailRouteArgs{key: $key, propertyId: $propertyId}';
  }
}

/// generated route for
/// [PropertyPage]
class PropertyRoute extends PageRouteInfo<PropertyRouteArgs> {
  PropertyRoute({
    Key? key,
    bool showBack = true,
    List<PageRouteInfo>? children,
  }) : super(
          PropertyRoute.name,
          args: PropertyRouteArgs(
            key: key,
            showBack: showBack,
          ),
          initialChildren: children,
        );

  static const String name = 'PropertyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PropertyRouteArgs>(
          orElse: () => const PropertyRouteArgs());
      return PropertyPage(
        key: args.key,
        showBack: args.showBack,
      );
    },
  );
}

class PropertyRouteArgs {
  const PropertyRouteArgs({
    this.key,
    this.showBack = true,
  });

  final Key? key;

  final bool showBack;

  @override
  String toString() {
    return 'PropertyRouteArgs{key: $key, showBack: $showBack}';
  }
}

/// generated route for
/// [SearchPropertyPage]
class SearchPropertyRoute extends PageRouteInfo<SearchPropertyRouteArgs> {
  SearchPropertyRoute({
    Key? key,
    bool showBack = true,
    int? beds,
    int? baths,
    int? minRange,
    int? maxRange,
    String? place,
    List<PageRouteInfo>? children,
  }) : super(
          SearchPropertyRoute.name,
          args: SearchPropertyRouteArgs(
            key: key,
            showBack: showBack,
            beds: beds,
            baths: baths,
            minRange: minRange,
            maxRange: maxRange,
            place: place,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchPropertyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchPropertyRouteArgs>(
          orElse: () => const SearchPropertyRouteArgs());
      return SearchPropertyPage(
        key: args.key,
        showBack: args.showBack,
        beds: args.beds,
        baths: args.baths,
        minRange: args.minRange,
        maxRange: args.maxRange,
        place: args.place,
      );
    },
  );
}

class SearchPropertyRouteArgs {
  const SearchPropertyRouteArgs({
    this.key,
    this.showBack = true,
    this.beds,
    this.baths,
    this.minRange,
    this.maxRange,
    this.place,
  });

  final Key? key;

  final bool showBack;

  final int? beds;

  final int? baths;

  final int? minRange;

  final int? maxRange;

  final String? place;

  @override
  String toString() {
    return 'SearchPropertyRouteArgs{key: $key, showBack: $showBack, beds: $beds, baths: $baths, minRange: $minRange, maxRange: $maxRange, place: $place}';
  }
}

/// generated route for
/// [SearchWorkspacePage]
class SearchWorkspaceRoute extends PageRouteInfo<SearchWorkspaceRouteArgs> {
  SearchWorkspaceRoute({
    Key? key,
    bool showBack = true,
    String? checkIn,
    String? checkOut,
    int? people,
    String? place,
    List<PageRouteInfo>? children,
  }) : super(
          SearchWorkspaceRoute.name,
          args: SearchWorkspaceRouteArgs(
            key: key,
            showBack: showBack,
            checkIn: checkIn,
            checkOut: checkOut,
            people: people,
            place: place,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchWorkspaceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchWorkspaceRouteArgs>(
          orElse: () => const SearchWorkspaceRouteArgs());
      return SearchWorkspacePage(
        key: args.key,
        showBack: args.showBack,
        checkIn: args.checkIn,
        checkOut: args.checkOut,
        people: args.people,
        place: args.place,
      );
    },
  );
}

class SearchWorkspaceRouteArgs {
  const SearchWorkspaceRouteArgs({
    this.key,
    this.showBack = true,
    this.checkIn,
    this.checkOut,
    this.people,
    this.place,
  });

  final Key? key;

  final bool showBack;

  final String? checkIn;

  final String? checkOut;

  final int? people;

  final String? place;

  @override
  String toString() {
    return 'SearchWorkspaceRouteArgs{key: $key, showBack: $showBack, checkIn: $checkIn, checkOut: $checkOut, people: $people, place: $place}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [StartPage]
class StartRoute extends PageRouteInfo<void> {
  const StartRoute({List<PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StartPage();
    },
  );
}

/// generated route for
/// [TenantFormPage]
class TenantFormRoute extends PageRouteInfo<void> {
  const TenantFormRoute({List<PageRouteInfo>? children})
      : super(
          TenantFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'TenantFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TenantFormPage();
    },
  );
}

/// generated route for
/// [WalkthroughPage]
class WalkthroughRoute extends PageRouteInfo<void> {
  const WalkthroughRoute({List<PageRouteInfo>? children})
      : super(
          WalkthroughRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalkthroughRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WalkthroughPage();
    },
  );
}

/// generated route for
/// [WebViewPage]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    Key? key,
    required String url,
    String? title,
    List<PageRouteInfo>? children,
  }) : super(
          WebViewRoute.name,
          args: WebViewRouteArgs(
            key: key,
            url: url,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'WebViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return WebViewPage(
        key: args.key,
        url: args.url,
        title: args.title,
      );
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.url,
    this.title,
  });

  final Key? key;

  final String url;

  final String? title;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title}';
  }
}

/// generated route for
/// [WorkspaceDetailPage]
class WorkspaceDetailRoute extends PageRouteInfo<WorkspaceDetailRouteArgs> {
  WorkspaceDetailRoute({
    Key? key,
    String? workspaceId,
    List<PageRouteInfo>? children,
  }) : super(
          WorkspaceDetailRoute.name,
          args: WorkspaceDetailRouteArgs(
            key: key,
            workspaceId: workspaceId,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkspaceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkspaceDetailRouteArgs>(
          orElse: () => const WorkspaceDetailRouteArgs());
      return WorkspaceDetailPage(
        key: args.key,
        workspaceId: args.workspaceId,
      );
    },
  );
}

class WorkspaceDetailRouteArgs {
  const WorkspaceDetailRouteArgs({
    this.key,
    this.workspaceId,
  });

  final Key? key;

  final String? workspaceId;

  @override
  String toString() {
    return 'WorkspaceDetailRouteArgs{key: $key, workspaceId: $workspaceId}';
  }
}

/// generated route for
/// [WorkspacePage]
class WorkspaceRoute extends PageRouteInfo<WorkspaceRouteArgs> {
  WorkspaceRoute({
    Key? key,
    bool showBack = true,
    bool? fromSearch,
    String? checkIn,
    String? checkOut,
    int? people,
    String? place,
    List<PageRouteInfo>? children,
  }) : super(
          WorkspaceRoute.name,
          args: WorkspaceRouteArgs(
            key: key,
            showBack: showBack,
            fromSearch: fromSearch,
            checkIn: checkIn,
            checkOut: checkOut,
            people: people,
            place: place,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkspaceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkspaceRouteArgs>(
          orElse: () => const WorkspaceRouteArgs());
      return WorkspacePage(
        key: args.key,
        showBack: args.showBack,
        fromSearch: args.fromSearch,
        checkIn: args.checkIn,
        checkOut: args.checkOut,
        people: args.people,
        place: args.place,
      );
    },
  );
}

class WorkspaceRouteArgs {
  const WorkspaceRouteArgs({
    this.key,
    this.showBack = true,
    this.fromSearch,
    this.checkIn,
    this.checkOut,
    this.people,
    this.place,
  });

  final Key? key;

  final bool showBack;

  final bool? fromSearch;

  final String? checkIn;

  final String? checkOut;

  final int? people;

  final String? place;

  @override
  String toString() {
    return 'WorkspaceRouteArgs{key: $key, showBack: $showBack, fromSearch: $fromSearch, checkIn: $checkIn, checkOut: $checkOut, people: $people, place: $place}';
  }
}

/// generated route for
/// [WorkspacePaymentPage]
class WorkspacePaymentRoute extends PageRouteInfo<WorkspacePaymentRouteArgs> {
  WorkspacePaymentRoute({
    Key? key,
    WorkspaceData? workspaceData,
    String? selectedData,
    num? selectedDays,
    String? startDate,
    String? endDate,
    List<PageRouteInfo>? children,
  }) : super(
          WorkspacePaymentRoute.name,
          args: WorkspacePaymentRouteArgs(
            key: key,
            workspaceData: workspaceData,
            selectedData: selectedData,
            selectedDays: selectedDays,
            startDate: startDate,
            endDate: endDate,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkspacePaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkspacePaymentRouteArgs>(
          orElse: () => const WorkspacePaymentRouteArgs());
      return WorkspacePaymentPage(
        key: args.key,
        workspaceData: args.workspaceData,
        selectedData: args.selectedData,
        selectedDays: args.selectedDays,
        startDate: args.startDate,
        endDate: args.endDate,
      );
    },
  );
}

class WorkspacePaymentRouteArgs {
  const WorkspacePaymentRouteArgs({
    this.key,
    this.workspaceData,
    this.selectedData,
    this.selectedDays,
    this.startDate,
    this.endDate,
  });

  final Key? key;

  final WorkspaceData? workspaceData;

  final String? selectedData;

  final num? selectedDays;

  final String? startDate;

  final String? endDate;

  @override
  String toString() {
    return 'WorkspacePaymentRouteArgs{key: $key, workspaceData: $workspaceData, selectedData: $selectedData, selectedDays: $selectedDays, startDate: $startDate, endDate: $endDate}';
  }
}
