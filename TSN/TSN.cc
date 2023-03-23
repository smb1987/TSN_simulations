#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;


class PacketGate : public cSimpleModule
{
  protected:
    cMessage *openGateEvent;
    cMessage *closeGateEvent;
    bool gateOpen;

    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(PacketGate);

void PacketGate::initialize()
{
    gateOpen = par("initiallyOpen").boolValue();
    double openTime = par("openTime").doubleValue();
    double closeTime = par("closeTime").doubleValue();

    openGateEvent = new cMessage("Open gate");
    closeGateEvent = new cMessage("Close gate");

    if (gateOpen)
        scheduleAt(simTime() + openTime, closeGateEvent);
    else
        scheduleAt(simTime() + closeTime, openGateEvent);

    if (strcmp("client", getName()) == 0)
    {
        cMessage *msg = new cMessage("PSFP test ...");
        send(msg, "out");
    }
}

void PacketGate::handleMessage(cMessage *msg)
{
    if (msg == openGateEvent)
    {
        gateOpen = true;
        double openTime = par("openTime").doubleValue();
        scheduleAt(simTime() + openTime, closeGateEvent);
    }
    else if (msg == closeGateEvent)
    {
        gateOpen = false;
        double closeTime = par("closeTime").doubleValue();
        scheduleAt(simTime() + closeTime, openGateEvent);
    }
    else
    {
        if (gateOpen)
        {
            send(msg, "out");
        }
        else
        {
            delete msg;
        }
    }
}
