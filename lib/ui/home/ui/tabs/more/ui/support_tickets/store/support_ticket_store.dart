import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/support_ticket_data.dart';
import 'package:balcony/data/repository/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'support_ticket_store.g.dart';

class SupportTicketStore = _SupportTicketStoreBase with _$SupportTicketStore;

abstract class _SupportTicketStoreBase with Store {
  @observable
  List<SupportTicketData>? supportTicketsResponse;

  @observable
  CommonData? createSupportTicketResponse;

  @observable
  CommonData? replySupportTicketResponse;

  @observable
  CommonData? closeSupportTicketResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getSupportTickets() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.getSupportTicket();
      if (response.isSuccess) {
        supportTicketsResponse = response.data?.tickets ?? [];
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future createSupportTicket(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.createSupportTicket(request);
      if (response.isSuccess) {
        createSupportTicketResponse = response.data;
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future replySupportTicket(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.replySupportTicket(request);
      if (response.isSuccess) {
        replySupportTicketResponse = response.data;
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future closeSupportTicket(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.closeSupportTicket(id);
      if (response.isSuccess) {
        closeSupportTicketResponse = response.data;
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}

final supportTicketStore = locator<SupportTicketStore>();
