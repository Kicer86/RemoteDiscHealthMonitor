
#include <QHash>

#include "AgentInformation.hpp"


uint qHash(const AgentInformation& info, uint seed)
{
    return qHash(info.m_name, seed) ^ qHash(info.m_host, seed) ^ qHash(info.m_port, seed);
}


AgentInformation::AgentInformation(const QString& name, const QHostAddress& host, quint16 port, DetectionSource ds)
    : m_name(name)
    , m_host(host)
    , m_port(port)
    , m_detectionSource(ds)
{

}


const QString& AgentInformation::name() const
{
    return m_name;
}


const QHostAddress& AgentInformation::host() const
{
    return m_host;
}


quint16 AgentInformation::port() const
{
    return m_port;
}


AgentInformation::DetectionSource AgentInformation::detectionSource() const
{
    return m_detectionSource;
}


bool AgentInformation::operator==(const AgentInformation& other) const
{
    return std::tie(m_port, m_host, m_name) == std::tie(other.m_port, other.m_host, other.m_name);
}


QDebug operator<<(QDebug debug, const AgentInformation& info)
{
    debug.nospace().noquote() << info.name();
    debug.nospace().noquote() << " (" << info.host() << ":" << info.port() << ")";

    return debug.maybeSpace();
}
